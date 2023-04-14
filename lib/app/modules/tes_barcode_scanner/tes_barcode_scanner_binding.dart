import 'package:get/get.dart';

import 'tes_barcode_scanner_controller.dart';

class TesBarcodeScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TesBarcodeScannerController>(
      () => TesBarcodeScannerController(),
    );
  }
}
