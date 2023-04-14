import 'home_routes.dart';
import 'login_routes.dart';
import 'mode_kasir_routes.dart';
import 'tes_barcode_scanner_routes.dart';
import 'tes_print_thermal_routes.dart';
import 'menu_kasir_routes.dart';
import 'ubah_ip_routes.dart';
import 'tutup_kas_kasir_routes.dart';
import 'kasir_kas_masuk_routes.dart';
import 'kasir_kas_keluar_routes.dart';
import 'kasir_terima_kas_routes.dart';
import 'tutup_kas_kasir_struk_routes.dart';
import 'penjualan_detail_routes.dart';
import 'penjualan_riwayat_routes.dart';
import 'bill_penjualan_routes.dart';
import 'bill_detail_routes.dart';


class AppPages {
  AppPages._();

  static const INITIAL = '/';

  static final routes = [
    ...HomeRoutes.routes,
    ...LoginRoutes.routes,
    ...ModeKasirRoutes.routes,
    ...TesBarcodeScannerRoutes.routes,
    ...TesPrintThermalRoutes.routes,
    ...MenuKasirRoutes.routes,
    ...UbahIpRoutes.routes,
    ...TutupKasKasirRoutes.routes,
    ...KasirKasMasukRoutes.routes,
    ...KasirKasKeluarRoutes.routes,
    ...KasirTerimaKasRoutes.routes,
    ...TutupKasKasirStrukRoutes.routes,
    ...PenjualanDetailRoutes.routes,
    ...PenjualanRiwayatRoutes.routes,
	
		...BillPenjualanRoutes.routes,
		...BillDetailRoutes.routes,
  ];
}
