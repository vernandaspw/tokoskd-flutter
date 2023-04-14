import 'package:get/get.dart';

import 'tutup_kas_kasir_controller.dart';

class TutupKasKasirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TutupKasKasirController>(
      () => TutupKasKasirController(),
    );
    // Get.put<TutupKasKasirController>(
    //   TutupKasKasirController(),
    // );
  }
}
