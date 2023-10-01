import 'package:donadona/model/enum/grade.dart';

class Payee {
  String id;
  String name;
  late Grade grade;
  String birthDate;
  String publicAddress;

  Payee(this.id, this.name, int grade, this.birthDate, this.publicAddress) {
    this.grade = Grade.getByValue(grade);
  }

  static Payee fromJson(Map<String, dynamic> json) {
    return Payee(json['id'], json['name'], json['grade'], json['birthDate'],json['publicAddress']);
  }
}