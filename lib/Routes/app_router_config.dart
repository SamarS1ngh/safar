import 'package:safar/feature/days/view/days.dart';
import 'package:safar/feature/home/view/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:safar/feature/stories/view/stories.dart';

class AppRouter {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
            path: 'stories',
            builder: (context, state) {
              final trip = state.extra as Map<String, dynamic>;
              return Stories(
                trip: trip["trip"],
              );
            },
            routes: [
              GoRoute(
                  path: 'day',
                  builder: (context, state) {
                    return const Days();
                  })
            ])
      ],
    )
  ]);
}
