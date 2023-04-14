import 'package:get/get.dart';

import 'bill_detail_controller.dart';

class BillDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillDetailController>(
      () => BillDetailController(),
    );
  }
}
