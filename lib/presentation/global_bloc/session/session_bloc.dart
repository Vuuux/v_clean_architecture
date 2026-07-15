import 'dart:async';

import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/app/app_router.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/dependency_injection.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/domain/interactors/interactors.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_greeting/feature2_greeting_page.dart';
import 'package:v_clean_architecture/presentation/utils/toast_util.dart';

part 'session_event.dart';
part 'session_state.dart';
part 'session_bloc_listener.dart';

/// ============================================================================
/// SESSION BLOC - Central Session Management
/// ============================================================================
///
/// **What is a Session?**
/// A session represents the user's authenticated state in the app.
/// It holds:
/// - Auth tokens (access + refresh)
/// - User profile data
/// - Session validity status
///
/// **Session Lifecycle:**
/// ```
/// [App Launch]
///     ↓
/// [Check Local Tokens] → No tokens? → [Login Screen]
///     ↓
/// [Tokens Found]
///     ↓
/// [Validate/Refresh if needed]
///     ↓
/// [Fetch User Profile]
///     ↓
/// [Session Active] ←→ [API Calls use Access Token]
///     ↓
/// [Logout/Token Expired]
///     ↓
/// [Clear Session] → [Login Screen]
/// ```
///
/// **Why Session Management Matters:**
/// 1. **Security**: Tokens expire, sessions can be invalidated
/// 2. **UX**: Seamless re-authentication with refresh tokens
/// 3. **State**: User data available throughout the app
/// 4. **Multi-device**: Server can track/revoke sessions
/// ============================================================================

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc({
    required AuthInteractor authInteractor,
    required UserInteractor userInteractor,
  }) : _authInteractor = authInteractor,
       _userInteractor = userInteractor,
       super(const SessionInitial()) {
    on<SessionAuthTokensUpdated>(_onAuthTokensUpdated);
    on<SessionRetriveAuthTokensStarted>(_onRetriveAuthTokensStarted);
    on<SessionLogoutRequested>(_onLogoutRequested);
    on<SessionFetchUserDataStarted>(_onFetchUserData);
    on<SessionUserDataUpdated>(_onUserDataUpdated);
  }

  factory SessionBloc.initialize() {
    return SessionBloc(
      authInteractor: DI().get<AuthInteractor>(),
      userInteractor: DI().get<UserInteractor>(),
    );
  }

  final AuthInteractor _authInteractor;
  final UserInteractor _userInteractor;

  /// ==========================================================================
  /// STEP 1: Retrieve Stored Auth Tokens
  /// ==========================================================================
  /// Called on app launch to check if user was previously logged in.
  ///
  /// Flow:
  /// 1. Check secure storage for saved tokens
  /// 2. If tokens exist → user was logged in before
  /// 3. If no tokens → user needs to login
  ///
  /// This enables "Remember Me" functionality without re-entering credentials.
  /// ==========================================================================
  Future<void> _onRetriveAuthTokensStarted(
    SessionRetriveAuthTokensStarted event,
    Emitter<SessionState> emit,
  ) async {
    final authTokens = await _authInteractor.getLocalAuthTokens();

    // Debug: Print token status
    if (kDebugMode && authTokens != null) {
      print(authTokens.statusSummary);
    }

    emit(
      SessionRetriveLocalAuthTokensSuccess(
        authTokens: authTokens,
      ),
    );
  }

  /// ==========================================================================
  /// STEP 2: Fetch User Profile Data
  /// ==========================================================================
  /// After confirming valid tokens, fetch the user's profile.
  ///
  /// Why fetch on every launch?
  /// - User data may have changed on other devices
  /// - Permissions may have been updated
  /// - Profile picture may have changed
  /// - Validates that the token is actually working
  /// ==========================================================================
  Future<AppUser> _fetchUserProfile(Emitter<SessionState> emit) async {
    final result = await _userInteractor.getCurrentUserProfile();
    emit(SessionUserDataUpdateSuccess(state, userData: result));
    return result;
  }

  Future<void> _onFetchUserData(
    SessionFetchUserDataStarted event,
    Emitter<SessionState> emit,
  ) async {
    try {
      // Prevent duplicate fetches
      if (state is SessionFetchUserDataInProgress) {
        return;
      }

      emit(SessionFetchUserDataInProgress(state));

      final userResult = await Future.wait([
        _fetchUserProfile(emit),
      ], eagerError: true);

      final userData = userResult.first;

      emit(
        SessionFetchUserDataSuccess(
          state,
          userData: userData,
          shouldRedirect: event.shouldRedirect,
        ),
      );
    } catch (err) {
      // =======================================================================
      // ERROR HANDLING
      // =======================================================================
      // Network errors: Show retry option, don't logout
      // Auth errors (401): Token invalid, force logout
      // Other errors: Log and handle gracefully
      // =======================================================================

      if (err is ApiException && err.isNetworkError) {
        emit(SessionNetworkError(state));
        return;
      }
      rethrow;
    }
  }

  /// ==========================================================================
  /// Token Update Handler
  /// ==========================================================================
  /// Called when tokens are refreshed or updated.
  /// Updates the session state with new tokens.
  /// ==========================================================================
  Future<void> _onAuthTokensUpdated(
    SessionAuthTokensUpdated event,
    Emitter<SessionState> emit,
  ) async {
    final authTokens = await _authInteractor.getLocalAuthTokens();
    emit(
      SessionAuthTokensUpdateSuccess(
        authTokens: authTokens,
      ),
    );
  }

  /// ==========================================================================
  /// LOGOUT FLOW
  /// ==========================================================================
  /// Proper logout involves:
  /// 1. Notify server (invalidate refresh token on server)
  /// 2. Clear local token storage
  /// 3. Clear in-memory session state
  /// 4. Navigate to login screen
  ///
  /// **Force Logout:**
  /// Used when server rejects the token (expired/revoked)
  /// - No toast message (user didn't initiate)
  /// - Immediate redirect to login
  /// ==========================================================================
  Future<void> _onLogoutRequested(
    SessionLogoutRequested event,
    Emitter<SessionState> emit,
  ) async {
    emit(
      const SessionLogoutInProgress(),
    );

    try {
      // Notify server and clear local storage
      await _authInteractor.signOut();
      emit(SessionLogoutSuccess(isForce: event.isForce));
    } catch (err) {
      // Even if server call fails, clear local session
      // User should still be logged out locally
      emit(
        SessionLogoutSuccess(isForce: event.isForce),
      );
    }
  }

  /// ==========================================================================
  /// User Data Update Handler
  /// ==========================================================================
  /// Called when user data changes (profile update, points earned, etc.)
  /// Updates the session state without re-fetching from server.
  /// ==========================================================================
  Future<void> _onUserDataUpdated(
    SessionUserDataUpdated event,
    Emitter<SessionState> emit,
  ) async {
    final currentUser = state.userData;
    if (currentUser == null) return;

    AppUser? updatedUser;

    // Example: Update user points
    // updatedUser = currentUser.copyWith(points: event.userPoint);

    emit(
      SessionUserDataUpdateSuccess(
        state,
        userData: updatedUser ?? currentUser,
      ),
    );
  }
}
