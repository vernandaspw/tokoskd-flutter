import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';

class TutupKasKasirController extends GetxController {
  //TODO: Implement TutupKasKasirController.

  late final TextEditingController kasTutupC;
  late final TextEditingController kasdiTarikC;

  var selisih = 0.obs;
  var kas_tutup = 0.obs;
  var kas_ditarik = 0.obs;
  var sisa_dikasir = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getTutupKasKasir(Get.parameters['id']);
    kasTutupC = new TextEditingController();
    kasdiTarikC = new TextEditingController();
    selisih.value = 0;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    kasTutupC.dispose();
    kasdiTarikC.dispose();
  }

  void hitungSelisih(value) async {
    if (value == null || value != 0) {
      kas_tutup.value = int.parse(value);
      var selisihData = int.parse(value) - data['kas_akhir'];
      selisih.value = selisihData.toInt();
    } else {
      kas_tutup.value = 0;
      selisih.value = 0;
    }
    hitungSisaDikasir(kas_ditarik.value);
  }

  void hitungSisaDikasir(value) {
    if (value != null || value != 0) {
      kas_ditarik.value = value;
      sisa_dikasir.value = kas_tutup.value - int.parse(value.toString());
    } else {
      kas_ditarik.value = 0;
      sisa_dikasir.value = kas_tutup.value;
    }
  }

  var isLoading = false.obs;
  var data = {}.obs;
  void getTutupKasKasir(kasir_id) async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.post(
        Uri.parse(
          '${dataUrl}modekasir/get-tutup-kas-kasir',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {'kasir_id': kasir_id},
      );
      // print(response.statusCode);

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        data.value = res['data'];
      }
    } finally {
      isLoading(false);
    }
  }

  var loadingSimpan = false.obs;

  void simpanData() async {
    loadingSimpan(true);
    if (kas_tutup == null || kas_tutup == 0) {
      Get.snackbar(
        'Perhatian',
        'kas tutup wajib di isi',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      loadingSimpan(false);
    } else if (kas_ditarik == null || kas_ditarik == 0) {
      Get.snackbar(
        'perhatian',
        'kas di tarik wajib diisi',
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
          '${dataUrl}modekasir/tutup-kas-kasir',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'kasir_id': Get.parameters['id'].toString(),
          'kas_tutup': kas_tutup.toString(),
          'kas_ditarik': kas_ditarik.toString(),
        },
      );
      // print(response.statusCode);

      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        data.value = res;
        // jika berhasil page tutup-kas-kasir-berhasil klik pilihan print / kembali
        Get.offNamed('/tutup-kas-kasir-struk/${res['data']['id']}');
      }
      loadingSimpan(false);
    }
  }
}
