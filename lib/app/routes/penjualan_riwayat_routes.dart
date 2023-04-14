import 'package:get/get.dart';

import '../modules/penjualan_riwayat/penjualan_riwayat_binding.dart';
import '../modules/penjualan_riwayat/penjualan_riwayat_page.dart';

class PenjualanRiwayatRoutes {
  PenjualanRiwayatRoutes._();

  static const penjualanRiwayat = '/penjualan-riwayat';

  static final routes = [
    GetPage(
      name: penjualanRiwayat,
      page: () => const PenjualanRiwayatPage(),
      binding: PenjualanRiwayatBinding(),
    ),
  ];
}
