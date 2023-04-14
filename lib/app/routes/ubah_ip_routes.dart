import 'package:get/get.dart';

import '../modules/ubah_ip/ubah_ip_binding.dart';
import '../modules/ubah_ip/ubah_ip_page.dart';

class UbahIpRoutes {
  UbahIpRoutes._();

  static const ubahIp = '/ubah-ip';

  static final routes = [
    GetPage(
      name: ubahIp,
      page: () => const UbahIpPage(),
      binding: UbahIpBinding(),
    ),
  ];
}
