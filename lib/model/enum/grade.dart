enum Grade {
  MiddleFirst(0),
  MiddleSecond(1),
  MiddleThird(2),
  HighFirst(3),
  HighSecond(4),
  HighThird(5);

  const Grade(this.value);
  final num value;
  
  static Grade getByValue(num i){
    return Grade.values.firstWhere((x) => x.value == i);
  }
}