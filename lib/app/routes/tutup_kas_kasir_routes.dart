import 'package:get/get.dart';

import '../modules/tutup_kas_kasir/tutup_kas_kasir_binding.dart';
import '../modules/tutup_kas_kasir/tutup_kas_kasir_page.dart';

class TutupKasKasirRoutes {
  TutupKasKasirRoutes._();

  static const tutupKasKasir = '/tutup-kas-kasir/:id';

  static final routes = [
    GetPage(
      name: tutupKasKasir,
      page: () => const TutupKasKasirPage(),
      binding: TutupKasKasirBinding(),
    ),
  ];
}
