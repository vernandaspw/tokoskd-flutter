import 'package:get/get.dart';

import '../modules/menu_kasir/menu_kasir_binding.dart';
import '../modules/menu_kasir/menu_kasir_page.dart';

class MenuKasirRoutes {
  MenuKasirRoutes._();

  static const menuKasir = '/menu-kasir';

  static final routes = [
    GetPage(
      name: menuKasir,
      page: () => const MenuKasirPage(),
      binding: MenuKasirBinding(),
    ),
  ];
}
