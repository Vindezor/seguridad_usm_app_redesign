import 'package:flutter/material.dart';
import 'package:test_design/ui/complete_profile/complete_profile_one_page.dart';
import 'package:test_design/ui/complete_profile/complete_profile_two_page.dart';
import 'package:test_design/ui/guide/guide_page.dart';
import 'package:test_design/ui/history/history_page.dart';
import 'package:test_design/ui/home/home_page.dart';
import 'package:test_design/ui/landing/landing_page.dart';
import 'package:test_design/ui/login/login_page.dart';
import 'package:test_design/ui/map/map_page.dart';
import 'package:test_design/ui/profile/profile_page.dart';
import 'package:test_design/ui/register/register_page.dart';
import 'package:test_design/ui/register/widgets/register_qr_scanner.dart';
import 'package:test_design/ui/register_successful/register_successful_page.dart';
import 'package:test_design/ui/settings/settings_page.dart';

import 'routes.dart';

Map<String, Widget Function(BuildContext context)> appRoutes() {
  return {
    Routes.landing: (_) => const LandingPage(),
    Routes.login: (_) => const LoginPage(),
    Routes.register: (_) => const RegisterPage(),
    Routes.registerSuccessful: (_) => const RegisterSuccessfulPage(),
    Routes.home: (_) => const HomePage(),
    Routes.profile: (_) => const ProfilePage(),
    Routes.history: (_) => const HistoryPage(),
    Routes.settings: (_) => const SettingsPage(),
    Routes.guide: (_) => const GuidePage(),
    Routes.registerQrScanner: (_) => const RegisterQrScanner(),
    Routes.map: (_) => const MapPage(),
    Routes.completeProfileOne: (_) => const CompleteProfileOnePage(),
    Routes.completeProfileTwo: (_) => const CompleteProfileTwoPage(),
  };
}