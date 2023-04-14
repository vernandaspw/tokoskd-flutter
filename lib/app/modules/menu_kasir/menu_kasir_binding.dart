import 'package:get/get.dart';

import 'menu_kasir_controller.dart';

class MenuKasirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuKasirController>(
      () => MenuKasirController(),
    );
    // Get.put<MenuKasirController>(
    //   MenuKasirController(),
    // );
    // Get.put(MenuKasirController());
  }
}
