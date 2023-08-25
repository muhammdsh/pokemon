import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../app+injection/app.dart';

import '../../app+injection/di.dart';

import '../../presentation/flows/startup_flow/screens/splash_screen.dart';
import '../blocs/application_bloc/app_bloc.dart';
import '../mediators/communication_types/AppStatus.dart';
import '../resources/colors.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final sectionNavigatorKey = GlobalKey<NavigatorState>();

class RoutesPath {
  static String get splashScreen => '/';

  static String get welcomePage => '/welcome';

  static String get loginPage => '$profilePage/login';

  static String get forgetPasswordPage => '$loginPage/forget-password';

  static String get register => '$loginPage/register';

  static String get verifyCodePage => '$forgetPasswordPage/verify-code';

  static String get resetPasswordPage => '$verifyCodePage/reset-password';

  static String get changePasswordSuccessPage => '$resetPasswordPage/change-success';

  static String get homepage => '/home';

  static String get productDetails => '/product-details';


  static String get category => '/category';

  static String get categoryDetailPage => '/category/detail';

  static String get bag => '/bag';

  static String get preCheckoutForm => '$bag/pre-checkout-form';

  static String get deliveryMethod => '$preCheckoutForm/delivery-method';

  static String get products => '/products';

  static String get wishList => '/wishlist';

  static String get profilePage => '/profile';
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
      builder: (context, state) => const Scaffold(
            body: Center(
              child: Text('home'),
            ),
          ),
      redirect: (context, goRouterState) {
        if (locator<AppBloc>().state.appStatus == Status.authorized &&
            goRouterState.path == RoutesPath.loginPage) {
          //return RoutesPath.rootPage;
        }
        return null;
      },
      routes: []),

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
