import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/data/sessions/Cart.dart';
import 'package:tokoskd/app/modules/mode_kasir/mode_kasir_controller.dart';

class BillDetailController extends GetxController {
  //TODO: Implement BillDetailController.
  var billID = Get.parameters['id'];
  var kasirID = Get.parameters['kasirid'];

  @override
  void onInit() {
    super.onInit();
    billID = Get.parameters['id'];
    kasirID = Get.parameters['kasirid'];

    findBill(billID);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var bill = {}.obs;
  var loadingData = false.obs;
  void findBill(id) async {
    loadingData(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';

    var response = await Api.client.get(
      Uri.parse(
        '${dataUrl}bill?id=${id.toString()}',
      ),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      bill.value = res['data'];
      loadingData(false);
    }
    loadingData(false);
  }

  var loadingProses = false.obs;
  void prosesBill(id) async {
    loadingProses(true);
    // hapus storage
    var cS = Cart();
    cS.clearItems();

    // get bill item
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';

    var response = await Api.client.get(
      Uri.parse(
        '${dataUrl}bill?id=${id.toString()}',
      ),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      var billItem = res['data']['bill_item'];
      for (var e in billItem) {
        // addStorageItem

        SharedPreferences prefs = await SharedPreferences.getInstance();
        // Session.getUserId().then((val) {
        //   user_id = val;
        // });
        // DateTime now = DateTime.now();
        // var waktuCreated = DateTime.now().millisecondsSinceEpoch;
        var item = Item(
          createdAt: int.parse(e['waktuCreate']),
          produkItemId: e['produk_item_id'],
          produkId: e['produk_id'],
          produkNama: e['produk_nama'],
          merekId: e['merek_id'],
          catalogId: e['catalog_id'],
          kategoriId: e['kategori_id'],
          rakId: e['rak_id'],
          satuanId: e['satuan_id'],
          satuan: e['satuan'],
          hargaModal: double.parse(e['harga_modal']),
          hargaJual: double.parse(e['harga_jual']),
          qty: double.parse(e['qty']),
          totalHargaModal: double.parse(e['total_harga_modal']),
          totalHargaJual: double.parse(e['total_harga_jual']),
          diskonPersen: double.parse(e['diskon_persen']),
          diskonHargaJual: double.parse(e['diskon_harga_jual']),
          potonganDiskon: double.parse(e['potongan_diskon']),
          totalHarga: double.parse(e['total_harga']),
          untung: double.parse(e['untung']),
        );

        final cartData = Cart();
        final items = await cartData.getItems();
        items.add(item);
        cartData.saveItems(items);
      }

      Get.find<ModeKasirController>().billID.value = id.toString();
      Get.find<ModeKasirController>().noDariBill.value =
          res['data']['no_bill'].toString();
      Get.find<ModeKasirController>().namaDariBill.value =
          res['data']['pelanggan_nama'].toString();
      Get.find<ModeKasirController>().fetchCart();

      // Get.offNamed('/mode-kasir/${kasirID}');
      // Get.offAndToNamed('/mode-kasir/${kasirID}');
      Get.back();
      Get.back();
      // Get.until((route) => Get.currentRoute == '/mode-kasir/${kasirID}');
      loadingProses(false);
    }

    loadingProses(false);
  }
}
