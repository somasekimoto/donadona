import 'package:donadona/api/login_api.dart';
import 'package:donadona/model/project.dart';
import 'package:donadona/util.dart';

class ProjectApi {
  static Future<List<Project>> getProject(String publicAddress) async {
    const path = 'assets/dummy_data/projects.json';
    final List<dynamic> json = await Util.readJson(path);
    List<Project> projects = json.map((item) => Project.fromJson(item)).toList();

    var payees = await LoginApi.getPayees(publicAddress);
    if (payees.isEmpty) return projects;
    var payee = payees[0];
    return projects.where((project) => project.payeeId == payee.id).toList();
  }

  static Future<Project?> getProjectById(String projectId) async {
    const path = 'assets/dummy_data/projects.json';
    final List<dynamic> json = await Util.readJson(path);
    List<Project> projects = json.map((item) => Project.fromJson(item)).toList();
    List<Project> filteredProjects = projects.where((project) => project.id == projectId).toList();
    if(filteredProjects.length != 1) return null;
    return filteredProjects[0];
  }
}