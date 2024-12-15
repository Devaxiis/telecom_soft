import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:go_router/go_router.dart';
import 'package:telecom_soft_ui/features/home/presentation/pages/audio_record.dart';
import 'package:telecom_soft_ui/features/home/presentation/pages/detail_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/splash/splash_screen.dart';


class Routes {
  static String get splash => "/";
  static String get audioRecord => "/audioRecord";
  static String get home => "/home";
  static String get detail => "/detail";
  static String get record => "/record";
  static String get chat => "/chat";

}

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

class AppRoutes {
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splash,
    routes: <RouteBase>[
      GoRoute(
          path: Routes.splash,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen()),
      GoRoute(
          path: Routes.home,
          builder: (BuildContext context, GoRouterState state) =>
              const HomePage()),
      GoRoute(
          path: Routes.audioRecord,
          builder: (BuildContext context, GoRouterState state) {
           final data = state.extra as String;
           return AudioRecord(title: data,);
          }
  ),

      GoRoute(
          path: Routes.detail,
          builder: (BuildContext context, GoRouterState state) {
          final data = state.extra as Map<String,dynamic>;
           String title = data["title"];
           bool isChat = data["isChat"];
             return DetailPage(title: title,isChat: isChat);
          },
          ),


      // StatefulShellRoute.indexedStack(
      //   builder: (BuildContext context, GoRouterState state,
      //       StatefulNavigationShell navigationShell) {
      //     return MainPage(child: navigationShell);
      //   },
      //   branches: <StatefulShellBranch>[
      //     // StatefulShellBranch(
      //     //   navigatorKey: _sectionANavigatorKey,
      //     //   routes: <RouteBase>[
      //     //     GoRoute(
      //     //       path: Routes.home,
      //     //       name: Routes.home,
      //     //       pageBuilder: (BuildContext context, GoRouterState state) {
      //     //         return buildPageWithDefaultTransition<void>(
      //     //             context: context, state: state, child: HomePage()
      //     //             );
      //     //       },
      //     //     ),
      //     //   ],
      //     // ),
      //
      //
      //   ],
      // ),
    ],
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 0),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
