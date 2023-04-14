import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/modules/menu_kasir/menu_kasir_controller.dart';

class TutupKasKasirStrukController extends GetxController {
  //TODO: Implement TutupKasKasirStrukController.
  List<BluetoothDevice> devices = [];
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void onInit() {
    super.onInit();
    getPrinter();
    getReport(Get.parameters['id']);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    refreshData();
  }

  refreshData() {
    // Refresh data
    Get.find<MenuKasirController>().getKasir();
    // update();
  }

  getPrinter() async {
    devices = await printer.getBondedDevices();
  }

  var isLoading = false.obs;
  var data = {}.obs;
  void getReport(report_id) async {
    try {
      isLoading(true);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.post(
        Uri.parse(
          '${dataUrl}modekasir/get-report',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'report_id': report_id,
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        data.value = res['data'];
        // print(data);
      }
    } finally {
      isLoading(false);
    }
  }
}
