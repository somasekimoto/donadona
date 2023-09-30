class Project {
  final String id;
  final String payeeId;
  final String projectName;
  final String overview;
  final String imagePath;
  final int targetMoney;
  final int studyTime;

  Project(this.id, this.payeeId, this.projectName, this.overview, this.imagePath, this.targetMoney, this.studyTime);

  static Project fromJson(Map<String, dynamic> json) {
    return Project(json['id'], json['payeeId'], json['projectName'], json['overview'], json['imagePath'], json['targetMoney'], json['studyTime']);
  }
}