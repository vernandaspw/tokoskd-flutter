import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/modules/menu_kasir/menu_kasir_controller.dart';

class KasirTerimaKasController extends GetxController {
  //TODO: Implement KasirTerimaKasController.
  late TextEditingController kasdiTarikC;
  var sisa_dikasir = 0.obs;
  var kas_ditarik = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getTerimaKas(Get.parameters['id']);
    kasdiTarikC = new TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    hitungSisaDikasir(0);
  }

  @override
  void onClose() {
    super.onClose();
    kasdiTarikC.dispose();
  }

  var isLoading = false.obs;
  var data = {}.obs;
  void getTerimaKas(kasir_id) async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.post(
        Uri.parse(
          '${dataUrl}modekasir/get-terima-kas-kasir',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {'kasir_id': kasir_id.toString()},
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        data.value = res['data'];
        // print(res);
      }
    } finally {
      isLoading(false);
    }
  }

  void hitungSisaDikasir(value) async {
    // kas tutup - kas ditarikC
    if (value != null && value != 0) {
      kas_ditarik.value = value;
      sisa_dikasir.value = data['kas_tutup'] - kas_ditarik.value;
    } else {
      kas_ditarik.value = data['kas_ditarik'] != null ? data['kas_dikasir'] : 0;
      sisa_dikasir.value =
          data['sisa_dikasir'] != null ? data['sisa_dikasir'] : 0;
    }
  }

  var loadingSimpan = false.obs;

  void simpanData() async {
    loadingSimpan(true);
    if (kas_ditarik == null || kas_ditarik == 0) {
      Get.snackbar(
        'perhatian',
        'kas di tarik yg diterima wajib diisi',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      loadingSimpan(false);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.post(
        Uri.parse(
          '${dataUrl}modekasir/terima-kas-kasir',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'kasir_report_id': data['id'].toString(),
          'kas_diterima': kas_ditarik.toString(),
          // 'sisa_dikasir': sisa_dikasir,
          // apakah sisa dikasir terbaru perlu?? cek api dulu
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        var res = json.decode(response.body);

        // refresh menu kasir dulu
        refreshData();
        Get.back();
        // untal ke halaman menu
      }
      loadingSimpan(false);
    }
  }

  refreshData() {
    // Refresh data
    Get.find<MenuKasirController>().getKasir();
    // update();
  }
}
