import 'package:donadona/layouts/layout.dart';
import 'package:donadona/pages/login_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (BuildContext context) => const DefaultLayout(title: 'ログイン', body: LoginPage())
    };
  }
}