import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';

class PenjualanDetailController extends GetxController {
  //TODO: Implement PenjualanDetailController.
  var loadingData = false.obs;
  var penjualan = {}.obs;
  var penjualanid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    penjualanid.value = Get.parameters['penjualanid'].toString();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async {
    loadingData(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';

    var response = await Api.client.post(
      Uri.parse(
        '${dataUrl}detail-penjualan',
      ),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'penjualanid': penjualanid.toString(),
      },
    );

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      // print(res);
      penjualan.value = res['data'];
      print(penjualan.value);
      // print(produkModel?.data.data[]);
      // produkData.value = res;
      loadingData(false);
    }
  }
}
