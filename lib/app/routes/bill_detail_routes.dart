import 'package:get/get.dart';

import '../modules/bill_detail/bill_detail_binding.dart';
import '../modules/bill_detail/bill_detail_page.dart';

class BillDetailRoutes {
  BillDetailRoutes._();

  static const billDetail = '/bill-detail/:id/:kasirid';

  static final routes = [
    GetPage(
      name: billDetail,
      page: () => const BillDetailPage(),
      binding: BillDetailBinding(),
    ),
  ];
}
