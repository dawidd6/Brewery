class Cask {
  final String name;

  Cask({this.name});

  factory Cask.fromJson(Map<String, dynamic> json) {
    return Cask(
      name: json['name'],
    );
  }
}
