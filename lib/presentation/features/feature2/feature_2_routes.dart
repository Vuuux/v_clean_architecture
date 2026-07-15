import 'package:go_router/go_router.dart';
import 'package:v_clean_architecture/constants/route_names.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_greeting/feature2_greeting_page.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_guidance/feature2_guidance_page.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_landing/feature2_landing_page.dart';
import 'package:v_clean_architecture/presentation/features/feature2/feature2_with_id_path/feature2_with_id_path_page.dart';

final class Feature2Routes {
  Feature2Routes._();

  static List<GoRoute> generateWithoutMainLayout() {
    return [
      GoRoute(
        path: '/${RouteNames.feature2guidance}',
        name: RouteNames.feature2guidance,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: Feature2GuidancePage(),
        ),
      ),
      GoRoute(
        path: '/${RouteNames.feature2withId}/:id',
        name: RouteNames.feature2withId,
        pageBuilder: (context, state) {
          // context.pushNamed(
          //   RouteNames.feature2withId,
          //   pathParameters: {'id': id},
          // );
          final id = state.pathParameters['id'] ?? '';
          return NoTransitionPage(
            child: Feature2WithIdPathPage(id: id),
          );
        },
      ),
    ];
  }

  static List<GoRoute> generateWithMainLayout() {
    return [
      GoRoute(
        path: RouteNames.feature2greeting,
        name: RouteNames.feature2greeting,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: Feature2GreetingPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.feature2landing,
        name: RouteNames.feature2landing,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: Feature2LandingPage(),
        ),
      ),
    ];
  }
}
