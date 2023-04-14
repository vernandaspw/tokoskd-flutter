import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoskd/app/data/models/User.dart';
import 'package:tokoskd/app/data/services/auth_services.dart';
import 'package:tokoskd/app/data/sessions/session.dart';
import 'package:tokoskd/app/routes/login_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  bool isAuthenticated = false;

  @override
  RouteSettings? redirect(String? route) {
    AuthServices.me().then((value) {
      var res = value;
      if (res != null) {
        if (res['code'] != 200) {
          return const RouteSettings(name: LoginRoutes.login);
        }
      } else {
        // Get.offAllNamed('/login');
        return const RouteSettings(name: LoginRoutes.login);
      }
    });
  }

  //This function will be called  before anything created we can use it to
  // change something about the page or give it new page
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }

  //This function will be called right before the Bindings are initialized.
  // Here we can change Bindings for this page.
  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    return super.onBindingsStart(bindings);
  }

  //This function will be called right after the Bindings are initialized.
  // Here we can do something after  bindings created and before creating the page widget.
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    return super.onPageBuildStart(page);
  }

  // Page build and widgets of page will be shown
  @override
  Widget onPageBuilt(Widget page) {
    return super.onPageBuilt(page);
  }

  //This function will be called right after disposing all the related objects
  // (Controllers, views, ...) of the page.
  @override
  void onPageDispose() {
    super.onPageDispose();
  }
}
