class Cask {
  final String token;
  final String version;
  final String description;

  Cask({
    required this.token,
    required this.version,
    required this.description,
  });

  factory Cask.fromJson(Map<String, dynamic> json) {
    return Cask(
      token: json['token'],
      version: json['version'],
      description: json['desc'] ?? '',
    );
  }
}

extension CaskList on List<Cask> {
  Cask findByToken(String token) {
    return firstWhere((cask) => cask.token == token);
  }
}
