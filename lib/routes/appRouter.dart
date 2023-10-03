import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/models/noteDataModel.dart';
import 'package:noteapp/routes/routeNames.dart';
import 'package:noteapp/screens/editNotePage.dart';
import 'package:noteapp/screens/homepage.dart';
import 'package:noteapp/screens/noteViewingPage.dart';

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
    GoRoute(
      path: "/viewpage",
      name: RouteName.VIEWPAGE,
      pageBuilder: (BuildContext context, GoRouterState state) {
        NoteDataModel models = state.extra as NoteDataModel;
        return CustomTransitionPage(
          key: state.pageKey,
          child: NoteViewingPage(
            noteData: models,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: "/editpage",
      name: RouteName.EDITPAGE,
      pageBuilder: (BuildContext context, GoRouterState state) {
        NoteDataModel models = state.extra as NoteDataModel;
        return CustomTransitionPage(
          key: state.pageKey,
          child: EditNotePage(
            noteData: models,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
  ],
);
