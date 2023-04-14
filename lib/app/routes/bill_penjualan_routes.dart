import 'package:get/get.dart';

import '../modules/bill_penjualan/bill_penjualan_binding.dart';
import '../modules/bill_penjualan/bill_penjualan_page.dart';

class BillPenjualanRoutes {
  BillPenjualanRoutes._();

  static const billPenjualan = '/bill-penjualan/:kasirid';

  static final routes = [
    GetPage(
      name: billPenjualan,
      page: () => const BillPenjualanPage(),
      binding: BillPenjualanBinding(),
    ),
  ];
}
