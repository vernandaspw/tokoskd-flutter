import 'package:get/get.dart';
import 'package:tokoskd/app/data/middlewares/AuthMiddleware.dart';

import '../modules/mode_kasir/mode_kasir_binding.dart';
import '../modules/mode_kasir/mode_kasir_page.dart';


class ModeKasirRoutes {
  ModeKasirRoutes._();

  static const modeKasir = '/mode-kasir/:kasirid';


  static final routes = [
    GetPage(
      name: modeKasir,
      page: () => const ModeKasirPage(),
      binding: ModeKasirBinding(),
      // middlewares: [AuthMiddleware(),],
    ),

  ];
}
