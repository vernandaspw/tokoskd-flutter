import 'package:get/get.dart';

import 'kasir_kas_masuk_controller.dart';

class KasirKasMasukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KasirKasMasukController>(
      () => KasirKasMasukController(),
    );
  }
}
