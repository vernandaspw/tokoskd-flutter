import 'package:get/get.dart';

import '../modules/kasir_terima_kas/kasir_terima_kas_binding.dart';
import '../modules/kasir_terima_kas/kasir_terima_kas_page.dart';

class KasirTerimaKasRoutes {
  KasirTerimaKasRoutes._();

  static const kasirTerimaKas = '/kasir-terima-kas/:id';

  static final routes = [
    GetPage(
      name: kasirTerimaKas,
      page: () => const KasirTerimaKasPage(),
      binding: KasirTerimaKasBinding(),
    ),
  ];
}
