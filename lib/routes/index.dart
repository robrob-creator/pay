import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kyogojo_pay/pages/applications/index.dart';
import 'package:kyogojo_pay/pages/login/index.dart';
import 'package:kyogojo_pay/providers/signup_provider.dart';
import 'package:provider/provider.dart';

class RouteBuilderGo {
  /// The route configuration.
  static GoRouter buildRoutes = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        final signupProvider = Provider.of<SignupDataProvider>(context);

        return signupProvider.accessToken == null || signupProvider == ""
            ? LoginPage()
            : ApplicationPage();
      },
    ),
    GoRoute(
      path: '/application',
      builder: (BuildContext context, GoRouterState state) {
        final signupProvider = Provider.of<SignupDataProvider>(context);

        return signupProvider.accessToken == null || signupProvider == ""
            ? LoginPage()
            : ApplicationPage();
      },
    ),
  ]);
}
