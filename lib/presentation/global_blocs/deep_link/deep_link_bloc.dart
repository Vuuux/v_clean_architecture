import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_clean_architecture/app/app_router.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/dependency_injection.dart';
import 'package:v_clean_architecture/domain/domain.dart';
import 'package:v_clean_architecture/presentation/features/feature1/feature1_page.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_page.dart';
import 'package:v_clean_architecture/presentation/features/login/login_page.dart';

part 'deep_link_bloc_listener.dart';
part 'deep_link_event.dart';
part 'deep_link_state.dart';

class DeepLinkBloc extends Bloc<DeepLinksEvent, DeepLinkState> {
  DeepLinkBloc._({
    required AppLinks appLinks,
    required AuthInteractor authInteractor,
  }) : _appLinks = appLinks,
       _authInteractor = authInteractor,
       super(DeepLinkInitial()) {
    on<DeepLinkStarted>(_onStarted);
    on<DeepLinkReceived>(_onDeepLinkReceived);
  }

  factory DeepLinkBloc.initialize() {
    return DeepLinkBloc._(
      appLinks: AppLinks(),
      authInteractor: DI().get<AuthInteractor>(),
    );
  }

  final AuthInteractor _authInteractor;
  final AppLinks _appLinks;
  StreamSubscription<Uri>? _applinkSubscription;

  @override
  Future<void> close() async {
    await super.close();
    await _applinkSubscription?.cancel();
  }

  Future<void> _onStarted(
    DeepLinkStarted event,
    Emitter<DeepLinkState> emit,
  ) async {
    if (_applinkSubscription != null) return;
    _applinkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        add(DeepLinkReceived(uri));
      }
    });
  }

  Future<void> _onDeepLinkReceived(
    DeepLinkReceived event,
    Emitter<DeepLinkState> emit,
  ) async {
    emit(const DeepLinkHandleInProgress());
    final uri = event.uri;
    final params = uri.queryParametersAll;
    final pageParam = uri.queryParameters['page'];
    final routeName = pageParam ?? uri.host;
    dynamic arguments;
    var authorizationRequired = false;
    var shouldPushNewPage = false;

    switch (routeName) {
      case RouteNames.feature1:
        authorizationRequired = true;
        shouldPushNewPage = true;
        final targetId = params['id']?.firstOrNull;
        arguments = Feature1Arguments(id: targetId ?? '');
      case RouteNames.feature2:
        final onboardingToken = params['onboarding_token']?.firstOrNull;
        await _authInteractor.setLocalAuthToken(
          AuthTokens(accessToken: onboardingToken),
        );
        arguments = Feature2Arguments(
          deepLinkType: DeepLinkType.batch,
        );
      // case RouteNames.profile:
      // final token = params['token']?.firstOrNull;
      // arguments = OthersPageArguments(token: token ?? '');
      default:
        authorizationRequired = false;
    }

    final authTokens = await _authInteractor.getLocalAuthTokens();

    emit(
      DeepLinkHandleSuccess(
        routeName: routeName,
        arguments: arguments,
        shouldLogin:
            authorizationRequired &&
            (authTokens == null || authTokens.isOnboardingUser),
        shouldPushNewPage: shouldPushNewPage,
      ),
    );
  }
}
