import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/data/models/User.dart';
import 'package:tokoskd/app/data/sessions/session.dart';

class AuthServices extends GetConnect {
  static Future<String?> login(String phone, String password) async {
    //
  }

  static Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? url = prefs.getString('url');
    var dataUrl = 'http://$url/api/';

    try {
      final response = await Api.client.post(
        Uri.parse(dataUrl + 'auth/logout'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('d');
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future me() async {
    try {
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
          return null;
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
          return res;
        } else {
          return null;
        }
      } else {
        // Get.offAllNamed("/login");
        return null;
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: 'Login ulang',
        textConfirm: 'login',
        onConfirm: () {
          Get.offAllNamed("/login");
        },
      );
      return null;
    }
  }

  // refresh token
  static Future refresh() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final String? url = prefs.getString('url');
      var dataUrl = 'http://$url/api/';

      var response = await Api.client.post(
        Uri.parse('${dataUrl}auth/refresh'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        // print(res);
        Session.saveToken(res['data']['token']);
        Session.saveNama(res['data']['nama']);
        Session.saveRole(res['data']['role']);

        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('token', res['data']['token']);
        return true;
      } else {
        // var res = jsonDecode(response.body);
        // print(res);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
