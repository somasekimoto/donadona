import 'package:donadona/model/payee.dart';
import 'package:donadona/model/payer.dart';
import 'package:donadona/util.dart';

class LoginApi {
  static Future<bool> certifyLogin(String publicAddress) async {
    // TODO: バックエンド作成したらapiコールに変更する
    var users = await LoginApi.getPayees(publicAddress);

    if(users.isEmpty) {
      const path2 = 'assets/dummy_data/payers.json';
      final List<dynamic> json2 = await Util.readJson(path2);
      List<Payer> payers = json2.map((item) => Payer.fromJson(item)).toList();
      var users2 = payers.where((payer) => payer.publicAddress == publicAddress);

      if(users2.isEmpty) return false;
    }
    return true;
  }

  static Future<List<Payee>> getPayees(String publicAddress) async {
    const path = 'assets/dummy_data/payees.json';
    final List<dynamic> json = await Util.readJson(path);
    List<Payee> payees = json.map((item) => Payee.fromJson(item)).toList();
    return payees.where((payee) => payee.publicAddress == publicAddress).toList();
  }
}