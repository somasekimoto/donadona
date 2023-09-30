import 'package:donadona/layouts/layout.dart';
import 'package:donadona/pages/login_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (BuildContext context) => const DefaultLayout(title: 'ログイン', body: LoginPage()),
      '/project/search': (BuildContext context) => const DefaultLayout(title: 'プロジェクトを探す', body: Column()),
      '/project/detail':(BuildContext context) => const DefaultLayout(title: 'プロジェクトを探す', body: Column()),
      '/project/edit':(BuildContext context) => const DefaultLayout(title: 'プロジェクトを探す', body: Column()),
      '/donate':(BuildContext context) => const DefaultLayout(title: 'プロジェクトを探す', body: Column()),
      '/withDraw':(BuildContext context) => const DefaultLayout(title: 'プロジェクトを探す', body: Column()),
    };
  }
}