import 'package:get/get.dart';

import 'penjualan_detail_controller.dart';

class PenjualanDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<PenjualanDetailController>(
    //   () => PenjualanDetailController(),
    // );
    Get.put<PenjualanDetailController>(
      PenjualanDetailController(),
    );
  }
}
