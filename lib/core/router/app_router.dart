import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router({
    required WidgetBuilder splashBuilder,
    required WidgetBuilder homeBuilder,
    required WidgetBuilder studentsBuilder,
    required Widget Function(BuildContext, String?) studentFormBuilder,
    required Widget Function(BuildContext, String) studentDetailsBuilder,
    required WidgetBuilder rankingBuilder,
    required WidgetBuilder aboutBuilder,
  }) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => splashBuilder(context),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => homeBuilder(context),
        ),
        GoRoute(
          path: '/students',
          builder: (context, state) => studentsBuilder(context),
          routes: [
            GoRoute(
              path: 'create',
              builder: (context, state) => studentFormBuilder(context, null),
            ),
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return studentDetailsBuilder(context, id);
              },
            ),
            GoRoute(
              path: ':id/edit',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return studentFormBuilder(context, id);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/ranking',
          builder: (context, state) => rankingBuilder(context),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => aboutBuilder(context),
        ),
      ],
    );
  }
}
