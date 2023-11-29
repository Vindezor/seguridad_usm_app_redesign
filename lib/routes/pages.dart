import 'package:flutter/material.dart';
import 'package:test_design/ui/landing/landing_page.dart';
import 'package:test_design/ui/login/login_page.dart';

import 'routes.dart';

Map<String, Widget Function(BuildContext context)> appRoutes() {
  return {
    Routes.landing: (_) => const LandingPage(),
    Routes.login: (_) => const LoginPage(),
  };
}