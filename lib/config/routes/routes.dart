// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_the_words/features/stage/presentation/pages/stage_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/routes_utils.dart';
import '../../error_screen.dart';
import '../../features/auth/presentation/pages/auth_screen.dart';
import '../../features/auth/presentation/pages/home_screen.dart';

class AppRouter {
  final GlobalKey<NavigatorState> rootNavigatorKey;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  AppRouter({
    required this.rootNavigatorKey,
    required this.scaffoldMessengerKey,
  });

  late final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const ErrorScreen(),
    initialLocation: '/auth',
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.auth.screenPath,
        name: PAGES.auth.screenName,
        builder: (context, state) => AuthScreen(
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.home.screenPath,
        name: PAGES.home.name,
        builder: (context, state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: PAGES.stage.screenPath,
        name: PAGES.stage.name,
        builder: (context, state) {
          return StageScreen();
        },
      ),
    ],
  );
}
