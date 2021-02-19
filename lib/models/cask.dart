class Cask {
  final String token;
  final String version;
  final String description;

  Cask({this.token, this.version, this.description});

  factory Cask.fromJson(Map<String, dynamic> json) {
    return Cask(
      token: json["token"],
      version: json["version"],
      description: json["desc"] ?? "",
    );
  }
}
