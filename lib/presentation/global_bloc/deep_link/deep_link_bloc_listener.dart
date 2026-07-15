part of './deep_link_bloc.dart';

extension DeepLinkBlocListener on DeepLinkBloc {
  void listener(DeepLinkState state) {
    final router = AppRouter.shared.router;
    switch (state.runtimeType) {
      case const (DeepLinkHandleSuccess):
        final currentState = state as DeepLinkHandleSuccess;
        if (currentState.shouldLogin) {
          router.goNamed(
            RouteNames.login,
            extra: LoginPageArguments(
              onLoginSuccess: () {
                router.goNamed(
                  currentState.routeName,
                  extra: currentState.arguments,
                );
              },
            ),
          );
          return;
        }
        if (currentState.shouldPushNewPage) {
          router.pushNamed(
            currentState.routeName,
            extra: currentState.arguments,
          );
          return;
        }
        router.goNamed(
          currentState.routeName,
          extra: currentState.arguments,
        );
    }
  }
}
