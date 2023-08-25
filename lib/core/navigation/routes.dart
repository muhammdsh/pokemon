import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app+injection/app.dart';

import '../../app+injection/di.dart';

import '../../presentation/flows/home_flow/screens/animations_screen.dart';
import '../../presentation/flows/home_flow/screens/home_screen.dart';
import '../../presentation/flows/startup_flow/screens/splash_screen.dart';
import '../blocs/application_bloc/app_bloc.dart';
import '../mediators/communication_types/AppStatus.dart';
import '../resources/colors.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionNavigatorKey = GlobalKey<NavigatorState>();

class RoutesPath {
  static String get splashScreen => '/';

  static String get welcomePage => '/welcome';

  static String get homepage => '/home';

  static String get animationPage => '$homepage/animation';
}

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  routes: routes,
  initialLocation: RoutesPath.splashScreen,
  refreshListenable: GoRouterRefreshStream(locator<AppBloc>().stream),
);

final List<RouteBase> routes = [
  GoRoute(
    parentNavigatorKey: rootNavigatorKey,
    name: "splash",
    path: "/",
    builder: (context, state) {
      print('ddddddddddd');
      return const SplashScreen();
    },
    redirect: (context, goState) {
      if (locator<AppBloc>().state.appStatus == Status.unauthorized &&
          goState.location == RoutesPath.splashScreen) {
        return RoutesPath.homepage;
      }
      return null;
    },
  ),
  GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'animation',
          builder: (context, state) => const AnimationScreen(),
        )
      ]),
];

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
