import 'package:app_core/app_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/dependency_injection.dart';
import 'package:v_clean_architecture/domain/entities/entities.dart';
import 'package:v_clean_architecture/domain/interactors/interactors.dart';

part 'login_event.dart';
part 'login_state.dart';

final class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthInteractor authInteractor,
  }) : _authInteractor = authInteractor,
       super(LoginInitial()) {
    on<LoginStarted>(_onLoginStarted);
    on<LoginSocialPressed>(_onLoginSocialPressed);
    on<LoginSocialCallbackStarted>(_onLoginSocialCallbackStarted);
  }

  factory LoginBloc.initialize() {
    return LoginBloc(authInteractor: DI().get<AuthInteractor>());
  }

  final AuthInteractor _authInteractor;

  Future<void> _onLoginStarted(
    LoginStarted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginInProgress());
    try {
      final response = await _authInteractor.signIn(
        username: event.username,
        password: event.password,
      );
      emit(
        LoginSuccess(
          needOnboard: response.isRegister,
        ),
      );
    } catch (err) {
      if (err is ApiException && err.code == 'err_login_locked') {
        emit(LoginLocked(message: err.message ?? 'Account locked'));
        return;
      } else {
        emit(LoginFailure(error: err));
      }
    }
  }

  Future<void> _onLoginSocialPressed(
    LoginSocialPressed event,
    Emitter<LoginState> emit,
  ) async {
    switch (event.provider) {
      case OAuthProvider.google:
        emit(LoginSocialInProgress());
        try {
          final response = await _authInteractor.signInWithGoogle();
          add(
            LoginSocialCallbackStarted(
              data: response,
              provider: OAuthProvider.google,
            ),
          );
        } catch (err) {
          emit(LoginSocialFailure(error: err));
        }
        return;
      case OAuthProvider.line:
        emit(LoginSocialInProgress());
        try {
          final response = await _authInteractor.signInWithLine();
          add(
            LoginSocialCallbackStarted(
              data: response,
              provider: OAuthProvider.line,
            ),
          );
        } catch (err) {
          emit(LoginSocialFailure(error: err));
        }
        return;
      case OAuthProvider.apple:
        emit(LoginSocialInProgress());
        try {
          final response = await _authInteractor.signInWithApple();
          add(
            LoginSocialCallbackStarted(
              data: response,
              provider: OAuthProvider.apple,
            ),
          );
        } catch (err) {
          emit(LoginSocialFailure(error: err));
        }
        return;
      case OAuthProvider.undefined:
        return;
    }
  }

  Future<void> _onLoginSocialCallbackStarted(
    LoginSocialCallbackStarted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final response = await _authInteractor.handleOAuthCallback(
        data: event.data,
        provider: event.provider,
      );
      emit(
        LoginSuccess(
          needOnboard: response.isRegister,
          provider: event.provider,
        ),
      );
    } catch (err) {
      emit(LoginSocialFailure(error: err));
    }
  }
}
