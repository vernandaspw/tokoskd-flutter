import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoskd/app/data/sessions/session.dart';

class Api {
  static var client = http.Client();
  // static const domain = 'https://api.vernandaspw.my.id';
  // static const url = '192.168.8.103/tokoskd/public/api/';
  // static const url = 'http://10.0.2.2:8000/tokoskd/public/api/';

  static getUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('url');
    var url = 'http://${data}/api/';
    return url;
  }

  // static const url = 'http://10.0.2.2:8000/api/';
}
