class Store {
  static final Store _store = Store._internal();

  int? userType;

  Store._internal();
  factory Store() => _store;

  setUserType(int userType) {
    this.userType = userType;
  }
}