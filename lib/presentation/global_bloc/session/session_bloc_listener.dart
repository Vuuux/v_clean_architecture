part of './session_bloc.dart';

extension SessionBlocListener on SessionBloc {
  void listener(
    SessionState state, {
    void Function()? onAppReady,
  }) {
    final router = AppRouter.shared.router;
    switch (state.runtimeType) {
      case const (SessionRetriveLocalAuthTokensSuccess):
        if (state.authTokens != null) {
          if (state.authTokens!.isOnboardingUser) {
            // not registered user, need to onboard
            router.goNamed(
              RouteNames.feature2greeting,
              extra: Feature2GreetingPageArguments(
                hasOnboardingToken: true,
              ),
            );
            return;
          }
          add(SessionFetchUserDataStarted());
        } else {
          router.goNamed(RouteNames.login);
          onAppReady?.call();
        }
        return;
      case const (SessionFetchUserDataSuccess):
        if (!(state as SessionFetchUserDataSuccess).shouldRedirect) {
          return;
        }
        if (state.userData?.stage?.needGoToOnboarding() ?? false) {
          router.goNamed(
            RouteNames.feature2greeting,
            extra: Feature2GreetingPageArguments(
              hasOnboardingToken: true,
            ),
          );
          return;
        }
        onAppReady?.call();
        return;
      case const (SessionLogoutSuccess):
        if (!(state as SessionLogoutSuccess).isForce) {
          showToast(title: 'Logged out successful!');
        }
        router.goNamed(RouteNames.login);
        return;
      case const (SessionNetworkError):
        final context = AppRouter.shared.rootNavigatorKey.currentContext;
        if (context == null) return;
        AppDialog.show(
          context,
          title: 'Network Error!',
          message: 'Please try again',
          barrierDismissible: false,
          actions: [
            AppDialogAction(
              label: 'OK',
              onPressed: () {
                router.goNamed(RouteNames.login);
              },
            ),
          ],
        );
    }
  }
}
