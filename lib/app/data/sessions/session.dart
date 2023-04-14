import 'dart:convert';
// import 'dart:ffi';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tokoskd/app/core/config/api.dart';
import 'package:tokoskd/app/data/models/User.dart';

class Session {
  // URL ==============================================================
  static Future<String?> saveUrl(url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // tambahkan
    await pref.setString('url', url);
    final String? data = pref.getString('url');
    return data;
  }

  static Future<String?> getUrl() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? data = pref.getString('url');
    var url = 'http://${data}/api/';
    return url;
  }
  // ==================================================================

  // TOKEN ==========================================================
  static Future<String?> saveToken(token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    final String? data = pref.getString('token');
    return data;
  }

  static Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? data = pref.getString('token');
    return data;
  }
// =====================================================================

// ID USER ==============================================================
  static Future<int?> saveUserId(userId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('userId', userId);
    final int? data = pref.getInt('userId');
    return data;
  }

  static Future<int?> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final int? data = pref.getInt('userId');
    return data;
  }
// ===================================================================

// NAMA ==============================================================
  static Future<String?> saveNama(userNama) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userNama', userNama);
    final String? data = pref.getString('userNama');
    return data;
  }

  static Future<String?> getNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? data = pref.getString('userNama');
    return data;
  }
// ===================================================================

// ROLE ==============================================================
  static Future<String?> saveRole(userRole) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userRole', userRole);
    final String? data = pref.getString('userRole');
    return data;
  }

  static Future<String?> getRole() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final String? data = pref.getString('userRole');
    return data;
  }

  // ==================================================================

// REMOVE ALL SESSION ===================================================
  static Future<String> removeAllSession() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.remove('userNama');
    await pref.remove('userRole');
    await pref.remove('url');
    var success = 'success';
    return success;
  }
  // ====================================================================
}
