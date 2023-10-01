import 'package:donadona/layouts/layout.dart';
import 'package:donadona/pages/donate_page.dart';
import 'package:donadona/pages/login_page.dart';
import 'package:donadona/pages/project_detail_page.dart';
import 'package:donadona/pages/project_list_page.dart';
import 'package:donadona/pages/withdraw_confirmation_page.dart';
import 'package:donadona/pages/withdraw_page.dart';
import 'package:flutter/material.dart';
import 'ethereum_screen.dart';


class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (BuildContext context) => const DefaultLayout(title: 'ログイン', body: LoginPage()),
      '/project/search': (BuildContext context) => const DefaultLayout(title: 'プロジェクトを探す', body: ProjectListPage()),
      '/project/detail':(BuildContext context) => const DefaultLayout(title: 'プロジェクト詳細', body: ProjectDetailPage()),
      '/project/edit':(BuildContext context) => const DefaultLayout(title: 'プロジェクトを探す', body: Column()),
      '/donate':(BuildContext context) => const DefaultLayout(title: '寄付', body: DonatePage()),
      '/ethereum': (BuildContext context) => const EthereumHomeScreen(),
      '/withdraw':(BuildContext context) => const DefaultLayout(title: 'お引出し', body: WithdrawPage()),
      '/withdraw/confirmation':(BuildContext context) => const DefaultLayout(title: 'お引出し確認', body: WithdrawConfirmationPage()),
    };
  }
}