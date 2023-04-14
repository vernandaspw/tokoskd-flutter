import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/data/services/auth_services.dart';
import 'package:tokoskd/app/data/sessions/session.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController.
  var isLoading = false.obs;
  var hidden = false.obs;

  var dataUrl = "".obs;

  late TextEditingController urlC;
  late TextEditingController phoneC;
  late TextEditingController passC;

  var validatePhone, validatePassword, validateUrl;

  @override
  void onInit() {
    super.onInit();
    urlC = new TextEditingController();
    phoneC = new TextEditingController();
    passC = new TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    // phoneC = new TextEditingController();
    // passC = new TextEditingController();
    // urlC = new TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    // urlC.dispose();
    // phoneC.dispose();
    // passC.dispose();
  }

  login(phone, password, inputUrl) async {
    // Session.saveUrl(inputUrl);
    // AuthServices.me().then((value) => print(value));
    // return null;
    // if (inputUrl != '') {
    // if (phone != '') {
    // if (password != '') {
    try {
      isLoading.value = true;
      // simpan ip dulu
      // cek ip tidak boleh kosong

      try {
        Session.saveUrl(inputUrl);
      } catch (e) {
        print(e);
      } finally {
        Api.getUrl().then((value) {
          dataUrl.value = value;
        });
        final response = await Api.client.post(
          Uri.parse(dataUrl.value + 'auth/login'),
          body: {
            'phone': phone,
            'password': password,
          },
        );

        if (response.statusCode == 200) {
          // jika berhasi save session
          var res = jsonDecode(response.body);
          Session.saveToken(res['data']['access_token']);
          Session.saveRole(res['data']['userRole']);
          Session.saveNama(res['data']['userNama']);
          Session.saveUserId(res['data']['userId']);

          // lalu redirect ke halaman home
          Get.offAllNamed('/');
        } else if (response.statusCode == 401) {
          var res = jsonDecode(response.body);
          validatePhone = res['data']['phone'];
          validatePassword = res['data']['password'];
        } else {
          var res = jsonDecode(response.body);
          Get.snackbar(
            'Gagal',
            res['msg'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print(e);
      // validateUrl = 'ip addres salah';
      Get.snackbar(
        'Gagal',
        'ip address salah',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
    //     } else {
    //       validatePassword = 'wajib di isi';
    //     }
    //   } else {
    //     validatePhone = 'wajib di isi';
    //   }
    // } else {
    //   validateUrl = 'wajib di isi!';
    // }
  }

  saveSession(String phone) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("phone", phone);
    await pref.setBool("isLogin", true);
  }

  cekLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("isLogin");
    if (islogin == null && islogin == false) {
      // jika tidak login route ke loginPage
    }
  }
}
