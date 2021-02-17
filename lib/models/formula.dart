class Formula {
  final String name;

  Formula({this.name});

  factory Formula.fromJson(Map<String, dynamic> json) {
    return Formula(
      name: json['name'],
    );
  }
}
