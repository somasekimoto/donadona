import 'package:donadona/model/enum/grade.dart';

class Payee {
  final String id;
  final String name;
  late Grade grade;
  final String birthDate;
  final String publicAddress;

  Payee(this.id, this.name, int grade, this.birthDate, this.publicAddress) {
    this.grade = Grade.getByValue(grade);
  }
}