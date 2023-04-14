import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/data/sessions/Cart.dart';
import 'package:tokoskd/app/data/sessions/session.dart';
import 'package:tokoskd/app/modules/mode_kasir/mode_kasir_controller.dart';

class BillPenjualanController extends GetxController {
  //TODO: Implement BillPenjualanController.
  var kasirID = Get.parameters['kasirid'];

  @override
  void onInit() {
    super.onInit();
    kasirID = Get.parameters['kasirid'];
    getBill();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    Get.find<ModeKasirController>().getBill();
    Get.find<ModeKasirController>().fetchCart();
  }

  var jmlBill = 0.obs;
  var dataBill = [].obs;

  var loadingBill = false.obs;
  void getBill() async {
    loadingBill(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';

    var response = await Api.client.get(
      Uri.parse(
        '${dataUrl}bill',
      ),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      print(res['data']);
      dataBill.value = res['data'];
      loadingBill(false);
    }
    loadingBill(false);
  }

  var deleteSuccess = false.obs;
  void deleteBill(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';

    var response = await Api.client.post(
      Uri.parse(
        '${dataUrl}bill-hapus',
      ),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      body: {
        'id': id.toString(),
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      deleteSuccess(true);
      getBill();
      Get.find<ModeKasirController>().getBill();
      Get.find<ModeKasirController>().fetchCart();
    }
  }
}
