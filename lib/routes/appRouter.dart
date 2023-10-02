import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/routes/routeNames.dart';
import 'package:noteapp/screens/homepage.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      path: "/",
      name: RouteName.HOMEPAGE,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),

    // GoRoute(
    //   path: "/initialscreen",
    //   name: RouteName.INITIALSCREEN,
    //   pageBuilder: (BuildContext context, GoRouterState state) {
    //     return CustomTransitionPage(
    //       key: state.pageKey,
    //       child: const InitialScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),
  ],
);
