class Formula {
  final String name;
  final String version;
  final String description;

  Formula({this.name, this.version, this.description});

  factory Formula.fromJson(Map<String, dynamic> json) {
    return Formula(
      name: json["name"],
      version: json["versions"]["stable"],
      description: json["desc"],
    );
  }
}
