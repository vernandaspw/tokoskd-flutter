import 'package:get/get.dart';

import 'ubah_ip_controller.dart';

class UbahIpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahIpController>(
      () => UbahIpController(),
    );
  }
}
