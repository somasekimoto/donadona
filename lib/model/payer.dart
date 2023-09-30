class Payer {
  final String id;
  final String name;
  final String birthDate;
  final String publicAddress;

  Payer(this.id, this.name, this.birthDate, this.publicAddress);

  static Payer fromJson(Map<String, dynamic> json) {
    return Payer(json['id'], json['name'], json['birthDate'],json['publicAddress']);
  }
}