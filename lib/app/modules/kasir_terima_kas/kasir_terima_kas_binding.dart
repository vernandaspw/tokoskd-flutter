import 'package:get/get.dart';

import 'kasir_terima_kas_controller.dart';

class KasirTerimaKasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KasirTerimaKasController>(
      () => KasirTerimaKasController(),
    );
  }
}
