import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:v_clean_architecture/constants/constants.dart';
import 'package:v_clean_architecture/presentation/features/feature1/feature1_page.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_page.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature_2_routes.dart';
import 'package:v_clean_architecture/presentation/features/feature3/feature3_page.dart';
import 'package:v_clean_architecture/presentation/features/login/login_page.dart';
import 'package:v_clean_architecture/presentation/features/main/main_page.dart';
import 'package:v_clean_architecture/presentation/features/profile/profile_page.dart';
import 'package:v_clean_architecture/presentation/features/splash/splash_page.dart';

final class AppRouter {
  factory AppRouter() => _instance;

  AppRouter._();

  static final _instance = AppRouter._();

  static AppRouter get shared => _instance;

  late final GlobalKey<NavigatorState> rootNavigatorKey;
  late final GoRouter router;

  void initialize(GlobalKey<NavigatorState> navigatorKey) {
    rootNavigatorKey = navigatorKey;
    _setupRouter();
  }

  void _setupRouter() {
    router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/${RouteNames.splash}',
      errorPageBuilder: (BuildContext context, GoRouterState state) =>
          MaterialPage<void>(
            key: state.pageKey,
            child: Scaffold(
              body: Center(
                child: Text('No route found for ${state.path}'),
              ),
            ),
          ),
      routes: [
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state, navigationShell) {
            return MainPage(
              navigationShell: navigationShell,
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${RouteNames.feature1}',
                  name: RouteNames.feature1,
                  builder: (context, state) {
                    final arguments = state.extra as Feature1Arguments?;
                    return Feature1Page(
                      arguments: arguments,
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${RouteNames.feature2}',
                  name: RouteNames.feature2,
                  builder: (context, state) {
                    final arguments = state.extra as Feature2Arguments?;
                    return Feature2Page(
                      arguments: arguments ?? Feature2Arguments(),
                    );
                  },
                  routes: Feature2Routes.generateWithMainLayout(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${RouteNames.feature3}',
                  name: RouteNames.feature3,
                  builder: (context, state) {
                    final arguments = state.extra as Feature3Arguments?;
                    return Feature3Page(
                      arguments: arguments,
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${RouteNames.profile}',
                  name: RouteNames.profile,
                  builder: (context, state) {
                    final arguments = state.extra as ProfilePageArguments?;
                    return ProfilePage(
                      arguments: arguments,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/${RouteNames.splash}',
          name: RouteNames.splash,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashPage(),
        ),
        GoRoute(
          path: '/${RouteNames.login}',
          name: RouteNames.login,
          builder: (BuildContext context, GoRouterState state) => LoginPage(
            arguments: state.extra as LoginPageArguments?,
          ),
        ),
        ...Feature2Routes.generateWithoutMainLayout(),
      ],
    );
  }

  static Page<T> scaleFadedTransitionPage<T>({
    required Widget page,
    LocalKey? key,
  }) {
    return CustomTransitionPage(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
