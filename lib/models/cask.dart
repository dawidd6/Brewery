class Cask {
  final String token;
  final String name;
  final String description;
  final String homepage;
  final String version;
  final String caveats;
  final String dependsOnMacOS;
  final List<String> dependsOnFormulae;
  final List<String> dependsOnCasks;
  final List<String> conflictsWithFormulae;
  final List<String> conflictsWithCasks;
  final bool autoUpdates;
  final int installs30d;
  final int installs90d;
  final int installs365d;

  String get coreTapURL =>
      'https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/$token.rb';

  Cask({
    required this.token,
    required this.name,
    required this.description,
    required this.homepage,
    required this.version,
    required this.caveats,
    required this.dependsOnMacOS,
    required this.dependsOnFormulae,
    required this.dependsOnCasks,
    required this.conflictsWithFormulae,
    required this.conflictsWithCasks,
    required this.autoUpdates,
    required this.installs30d,
    required this.installs90d,
    required this.installs365d,
  });

  factory Cask.fromJson(Map<String, dynamic> json) {
    return Cask(
      token: json['token'],
      name: List<String>.from(json['name']).first,
      description: json['desc'] ?? '',
      homepage: json['homepage'],
      version: json['version'],
      caveats: json['caveats'] ?? '',
      dependsOnMacOS: json['depends_on']['macos'] != null
          ? json['depends_on']['macos'].entries.first.key +
              ' ' +
              json['depends_on']['macos'].entries.first.value.first
          : '',
      dependsOnFormulae: json['depends_on']['formula'] != null
          ? List<String>.from(json['depends_on']['formula'])
          : [],
      dependsOnCasks: json['depends_on']['cask'] != null
          ? List<String>.from(json['depends_on']['cask'])
          : [],
      conflictsWithFormulae: json['conflicts_with']?['formula'] != null
          ? List<String>.from(json['conflicts_with']['formula'])
          : [],
      conflictsWithCasks: json['conflicts_with']?['cask'] != null
          ? List<String>.from(json['conflicts_with']['cask'])
          : [],
      autoUpdates: json['auto_updates'] ?? false,
      installs30d: json['analytics']?['install']['30d'][json['token']] ?? 0,
      installs90d: json['analytics']?['install']['90d'][json['token']] ?? 0,
      installs365d: json['analytics']?['install']['365d'][json['token']] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'name': [name],
      'desc': description,
      'homepage': homepage,
      'version': version,
      'caveats': caveats,
      'depends_on': {
        'macos': {
          dependsOnMacOS.split(' ').first: [
            dependsOnMacOS.split(' ').last,
          ],
        },
        'cask': dependsOnCasks,
        'formula': dependsOnFormulae,
      },
      'conflicts_with': {
        'cask': conflictsWithCasks,
        'formula': conflictsWithFormulae,
      },
      'auto_updates': autoUpdates,
    };
  }
}

extension CaskListExtension on List<Cask> {
  Cask findCaskByToken(String token) {
    return firstWhere((cask) => cask.token == token);
  }

  bool isCaskPresent(String token) {
    return any((cask) => cask.token == token);
  }
}
