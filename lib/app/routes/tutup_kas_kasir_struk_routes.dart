import 'package:get/get.dart';

import '../modules/tutup_kas_kasir_struk/tutup_kas_kasir_struk_binding.dart';
import '../modules/tutup_kas_kasir_struk/tutup_kas_kasir_struk_page.dart';

class TutupKasKasirStrukRoutes {
  TutupKasKasirStrukRoutes._();

  static const tutupKasKasirStruk = '/tutup-kas-kasir-struk/:id';

  static final routes = [
    GetPage(
      name: tutupKasKasirStruk,
      page: () => const TutupKasKasirStrukPage(),
      binding: TutupKasKasirStrukBinding(),
    ),
  ];
}
