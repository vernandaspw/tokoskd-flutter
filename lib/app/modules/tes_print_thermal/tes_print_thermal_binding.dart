import 'package:get/get.dart';

import 'tes_print_thermal_controller.dart';

class TesPrintThermalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TesPrintThermalController>(
      () => TesPrintThermalController(),
    );
  }
}
