import 'package:get/get.dart';

import '../modules/tes_barcode_scanner/tes_barcode_scanner_binding.dart';
import '../modules/tes_barcode_scanner/tes_barcode_scanner_page.dart';

class TesBarcodeScannerRoutes {
  TesBarcodeScannerRoutes._();

  static const tesBarcodeScanner = '/tes-barcode-scanner';

  static final routes = [
    GetPage(
      name: tesBarcodeScanner,
      page: () => const TesBarcodeScannerPage(),
      binding: TesBarcodeScannerBinding(),
    ),
  ];
}
