import 'package:get/get.dart';

class TesBarcodeScannerController extends GetxController {
  //TODO: Implement TesBarcodeScannerController.
  var barcode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    print(barcode.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
