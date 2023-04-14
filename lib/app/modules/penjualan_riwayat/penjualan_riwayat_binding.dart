import 'package:get/get.dart';

import 'penjualan_riwayat_controller.dart';

class PenjualanRiwayatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PenjualanRiwayatController>(
      () => PenjualanRiwayatController(),
    );
  }
}
