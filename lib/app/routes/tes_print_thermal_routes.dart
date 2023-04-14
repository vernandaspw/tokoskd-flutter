import 'package:get/get.dart';

import '../modules/tes_print_thermal/tes_print_thermal_binding.dart';
import '../modules/tes_print_thermal/tes_print_thermal_page.dart';

class TesPrintThermalRoutes {
  TesPrintThermalRoutes._();

  static const tesPrintThermal = '/tes-print-thermal';

  static final routes = [
    GetPage(
      name: tesPrintThermal,
      page: () => const TesPrintThermalPage(),
      binding: TesPrintThermalBinding(),
    ),
  ];
}
