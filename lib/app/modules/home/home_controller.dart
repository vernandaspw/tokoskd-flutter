import 'dart:convert';
import 'dart:io';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/data/models/ModeKasir/KasirModel.dart';
import 'package:tokoskd/app/data/services/auth_services.dart';
import 'package:tokoskd/app/data/sessions/session.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController.
  var pageIndex = 0.obs;

  List<BluetoothDevice> devices = [];
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void onInit() {
    super.onInit();

    getRole();

    // getKasir();
    getPrinter();
  }

  @override
  void onReady() {
    super.onReady();
    refreshToken();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void fungsiCekPrinter() {

  // }

  var siapPrint = false.obs;
  var printerAda = false.obs;
  var printAddress = ''.obs;
  getPrinter() async {
    devices = await printer.getBondedDevices();
    var data = devices.where((element) {
      return element.name == 'RPP02N';
    });
    print({
      'Printer Address': data.isEmpty ? 'tidak ada printer' : data.last.address
    });
    data.isEmpty ? printerAda(false) : printerAda(true);
    if (printerAda == true) {
      // printer.disconnect();
      try {
        printer.isConnected.then((value) {
          if (value == true) {
            printer.disconnect();
            Future.delayed(Duration(seconds: 1));
            siapPrint(false);
            return Get.defaultDialog(
              title: 'Printer TIDAK AKTIF',
              middleText:
                  'Reload / swipe down / klik tes print untuk menghubungkan',
              backgroundColor: Colors.redAccent,
              textCancel: '  oke  ',
              titleStyle: TextStyle(color: Colors.white),
              middleTextStyle: TextStyle(
                color: Colors.white,
              ),
            );
          } else {
            printer.connect(data.last);

            siapPrint(true);
            printAddress.value = data.last.address.toString();
            Get.defaultDialog(
              title: 'Printer',
              middleText: 'terhubung dengan ${data.last.address}',
              backgroundColor: Colors.blueAccent,
            );
          }
        });
      } finally {}
    } else {
      siapPrint(false);
      printerAlert();
    }
  }

  void printerAlert() {
    Get.defaultDialog(
      title: 'Printer',
      middleText:
          'Tidak ada printer terhubung/ Bluetooth tidak menyala, hubungkan melalui bluetooth anda',
      backgroundColor: Colors.redAccent,
      textCancel: '  oke  ',
      titleStyle: TextStyle(color: Colors.white),
      middleTextStyle: TextStyle(
        color: Colors.white,
      ),
    );
  }

  var role = ''.obs;
  var nama = ''.obs;
  var url = ''.obs;
  void getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? roles = prefs.getString('userRole');
    final String? namas = prefs.getString('userNama');
    final String? urls = prefs.getString('url');
    role.value = roles.toString();
    nama.value = namas.toString();
    url.value = urls.toString();
    print(url);
  }

  var showUbahIp = false.obs;
  void getMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';
    // print(dataUrl);

    if (token != null && dataUrl != null) {
      var response = await Api.client.get(
        Uri.parse('${dataUrl}auth/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 401) {
        print('Ter logout');
      } else if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        // print(res);
        // REFRESH TOKEN DISINI

        // Session.saveToken(resRefresh['data']['token']);
        // Session.saveNama(resRef)

        // jika berhasil perbarui session token, nama, role

        // menyimpan data ke dalam model
        // var obj = User.fromJson(res);
        // print(obj);
        // return obj;
        Get.snackbar('Success', 'IP adress aman',
            backgroundColor: Colors.white);
      } else {
        print('Kesalahan server');
      }
    } else {
      Get.offAllNamed("/login");
    }
    try {
      AuthServices.me().then((value) {
        var res = value;
        print(res);
        if (res != null) {
          if (res['code'] != 200) {
            showUbahIp(false);
            Get.snackbar('IP Berubah', 'Ubah ip addres dengan klik Ubah IP');
          }
        } else {
          showUbahIp(false);
          Get.snackbar('IP Berubah', 'Ubah ip addres dengan klik Ubah IP');
        }
      });
    } catch (e) {
      print('kesalahan server');
    }
  }

  void refreshToken() async {
    AuthServices.refresh().then((value) {
      // print(value);
      if (value == true) {
        print('success refresh token');
      } else {
        print('error refresh token');
        // tampilkan alert dan tombol ubah ip
      }
    });
  }

  // KasirModel? kasirModel = KasirModel.obs;
  // var kasirLoading = true.obs;

  // void getKasir() async {
  //   try {
  //     kasirLoading(true);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String? token = prefs.getString('token');
  //     final String? url = prefs.getString('url');

  //     var dataUrl = 'http://$url/api/';

  //     var response = await Api.client.get(
  //       Uri.parse(
  //         '${dataUrl}modekasir/kasir',
  //       ),
  //       headers: {
  //         'Authorization': 'Bearer ${token}',
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       var res = await json.decode(response.body);
  //       kasirModel = KasirModel.fromJson(res);
  //       // print(res);
  //     }
  //     // if (response.statusCode == 401) {
  //     //   logout();
  //     // }
  //   } finally {
  //     kasirLoading(false);
  //   }
  // }

  logout() async {
    try {
      AuthServices.logout().then(
        (value) {
          if (value != null) {
            Session.removeAllSession();
            Get.offAllNamed("/login");
          } else {
            Session.removeAllSession();
            Get.offAllNamed("/login");
            // Get.defaultDialog(
            //   title: "Terjadi kesalahan",
            //   middleText: 'Login ulang',
            //   textConfirm: 'login',
            //   onConfirm: () {
            //     Get.offNamed("/login");
            //   },
            // );
          }
        },
      );
    } finally {
      // print(e);
      Session.removeAllSession();
      Get.offAllNamed("/login");
    }
  }
}
