class Cask {
  final String name;

  Formula({this.name});

  factory Cask.fromJson(Map<String, dynamic> json) {
    return Cask(
      name: json['name'],
    );
  }
}
