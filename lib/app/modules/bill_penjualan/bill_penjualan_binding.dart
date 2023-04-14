import 'package:get/get.dart';

import 'bill_penjualan_controller.dart';

class BillPenjualanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillPenjualanController>(
      () => BillPenjualanController(),
    );
  }
}
