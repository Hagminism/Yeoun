import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const Scaffold();
      },
    ),
  ],
);
