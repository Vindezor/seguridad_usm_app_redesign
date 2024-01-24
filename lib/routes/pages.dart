import 'package:flutter/material.dart';
import 'package:test_design/ui/administrate/administrate_page.dart';
import 'package:test_design/ui/administrate/admins/add_edit_admin/add_edit_admin_page.dart';
import 'package:test_design/ui/administrate/admins/administrate_admins_page.dart';
import 'package:test_design/ui/administrate/brands/add_edit_brand/add_edit_brand_page.dart';
import 'package:test_design/ui/administrate/brands/administrate_brands_page.dart';
import 'package:test_design/ui/administrate/drivers/add_edit_driver/add_edit_driver_page.dart';
import 'package:test_design/ui/administrate/drivers/administrate_drivers_page.dart';
import 'package:test_design/ui/administrate/models/add_edit_model/add_edit_model_page.dart';
import 'package:test_design/ui/administrate/models/administrate_models_page.dart';
import 'package:test_design/ui/administrate/routes/add_edit_route/add_edit_route_page.dart';
import 'package:test_design/ui/administrate/routes/administrate_routes_page.dart';
import 'package:test_design/ui/administrate/routes/map/route_map_page.dart';
import 'package:test_design/ui/administrate/stops/add_edit_stop/add_edit_stop_page.dart';
import 'package:test_design/ui/administrate/stops/administrate_stops_page.dart';
import 'package:test_design/ui/administrate/stops/map/stop_map_page.dart';
import 'package:test_design/ui/administrate/units/add_edit_unit/add_edit_unit_page.dart';
import 'package:test_design/ui/administrate/units/administrate_units_page.dart';
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
import 'package:test_design/ui/start_travel/start_travel_page.dart';
import 'package:test_design/ui/start_travel/widgets/travel_qr_scanner.dart';

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
    Routes.startRoute: (_) => const StartTravelPage(),
    Routes.travelQrScanner: (_) => const TravelQrScanner(),
    Routes.administrate: (_) => const AdministratePage(),
    Routes.administrateUnits: (_) => const AdministrateUnitsPage(),
    Routes.administrateStops: (_) => const AdministrateStopsPage(),
    Routes.administrateRoutes: (_) => const AdministrateRoutesPage(),
    Routes.administrateDrivers: (_) => const AdministrateDriversPage(),
    Routes.administrateAdmins: (_) => const AdministrateAdminsPage(),
    Routes.administrateBrands: (_) => const AdministrateBrandsPage(),
    Routes.administrateModels: (_) => const AdministrateModelsPage(),
    Routes.stopMap: (_) => const StopMapPage(),
    Routes.addEditStop: (_) => const AddEditStopPage(),
    Routes.addEditRoute: (_) => const AddEditRoutePage(),
    Routes.addEditDriver: (_) => const AddEditDriverPage(),
    Routes.addEditUnit: (_) => const AddEditUnitPage(),
    Routes.addEditBrand: (_) => const AddEditBrandPage(),
    Routes.addEditModel: (_) => const AddEditModelPage(),
    Routes.addEditAdmin: (_) => const AddEditAdminPage(),
    Routes.routeMap: (_) => const RouteMapPage(),
  };
}