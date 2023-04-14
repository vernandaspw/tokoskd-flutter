import 'package:get/get.dart';

import '../modules/kasir_kas_keluar/kasir_kas_keluar_binding.dart';
import '../modules/kasir_kas_keluar/kasir_kas_keluar_page.dart';

class KasirKasKeluarRoutes {
  KasirKasKeluarRoutes._();

  static const kasirKasKeluar = '/kasir-kas-keluar';

  static final routes = [
    GetPage(
      name: kasirKasKeluar,
      page: () => const KasirKasKeluarPage(),
      binding: KasirKasKeluarBinding(),
    ),
  ];
}
