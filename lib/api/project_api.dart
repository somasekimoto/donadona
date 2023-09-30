import 'package:donadona/api/login_api.dart';
import 'package:donadona/model/project.dart';
import 'package:donadona/util.dart';

class ProjectApi {
  static Future<List<Project>> getProject(String publicAddress) async {

    var payees = await LoginApi.getPayees(publicAddress);
    if (payees.length != 1) return [];
    var payee = payees[0];

    const path = 'assets/dummy_data/projects.json';
    final List<dynamic> json = await Util.readJson(path);
    List<Project> projects = json.map((item) => Project.fromJson(item)).toList();
    return projects.where((project) => project.payeeId == payee.id).toList();
  }
}