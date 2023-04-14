import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/data/models/ModeKasir/KasirModel.dart';

class MenuKasirController extends GetxController {
  //TODO: Implement MenuKasirController.

  @override
  void onInit() {
    super.onInit();
    getRole();
    getKasir();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var role = ''.obs;
  getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? roles = prefs.getString('userRole');
    role.value = roles.toString();
  }

  KasirModel? kasirModel = KasirModel.obs;
  var loadingKasir = false.obs;

  getKasir() async {
    loadingKasir(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';

    var response = await Api.client.get(
      Uri.parse(
        '${dataUrl}modekasir/kasir',
      ),
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      kasirModel = KasirModel.fromJson(res);
      // print(res);
    }
    // if (response.statusCode == 401) {
    //   logout();
    // }

    loadingKasir(false);
  }

// BUkA KAS KASIR
  var LoadingModeKasir = false.obs;

  void bukaKasKasir(kasir_id) async {
    try {
      LoadingModeKasir(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.post(
        Uri.parse(
          '${dataUrl}modekasir/buka-kas-kasir',
        ),
        headers: {
          'Authorization': 'Bearer ${token}',
        },
        body: {
          'kasir_id': kasir_id.toString(),
        },
      );
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        // jika berhasil go page mode kasir dengan beri parameter ID kasir
        if (res != null) {
          getKasir();
          Get.offNamed('/mode-kasir/${kasir_id}');
        }
        print('gagal');
      }
      // if (response.statusCode == 401) {
      //   logout();
      // }
    } catch (e) {
      print(e);
    } finally {
      LoadingModeKasir(false);
    }
  }
}
