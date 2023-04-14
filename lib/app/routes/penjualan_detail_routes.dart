import 'package:get/get.dart';

import '../modules/penjualan_detail/penjualan_detail_binding.dart';
import '../modules/penjualan_detail/penjualan_detail_page.dart';

class PenjualanDetailRoutes {
  PenjualanDetailRoutes._();

  static const penjualanDetail = '/penjualan-detail/:penjualanid';

  static final routes = [
    GetPage(
      name: penjualanDetail,
      page: () => const PenjualanDetailPage(),
      binding: PenjualanDetailBinding(),
    ),
  ];
}
