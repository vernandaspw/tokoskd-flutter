import 'package:get/get.dart';

import 'kasir_kas_keluar_controller.dart';

class KasirKasKeluarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KasirKasKeluarController>(
      () => KasirKasKeluarController(),
    );
  }
}
