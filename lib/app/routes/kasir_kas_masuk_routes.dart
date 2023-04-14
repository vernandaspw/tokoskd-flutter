import 'package:get/get.dart';

import '../modules/kasir_kas_masuk/kasir_kas_masuk_binding.dart';
import '../modules/kasir_kas_masuk/kasir_kas_masuk_page.dart';

class KasirKasMasukRoutes {
  KasirKasMasukRoutes._();

  static const kasirKasMasuk = '/kasir-kas-masuk';

  static final routes = [
    GetPage(
      name: kasirKasMasuk,
      page: () => const KasirKasMasukPage(),
      binding: KasirKasMasukBinding(),
    ),
  ];
}
