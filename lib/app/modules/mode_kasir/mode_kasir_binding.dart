import 'package:get/get.dart';
import 'package:tokoskd/app/modules/home/home_controller.dart';

import 'mode_kasir_controller.dart';

class ModeKasirBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ModeKasirController>(
    //   () => ModeKasirController(),
    // );
    Get.put<ModeKasirController>(
      ModeKasirController(),
    );
    // Get.put(ModeKasirController());
  }
}
