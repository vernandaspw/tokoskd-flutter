import 'package:get/get.dart';

import 'tutup_kas_kasir_struk_controller.dart';

class TutupKasKasirStrukBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<TutupKasKasirStrukController>(
    //   () => TutupKasKasirStrukController(),
    // );
    Get.put<TutupKasKasirStrukController>(
      TutupKasKasirStrukController(),
    );
  }
}
