class Formula {
  final String name;
  final String version;
  final String description;
  final String license;
  final String homepage;
  final String caveats;
  final String deprecateDate;
  final String deprecateReason;
  final String disableDate;
  final String disableReason;
  final int versionScheme;
  final int revision;
  final bool bottleDisabled;
  final bool kegOnly;
  final bool deprecated;
  final bool disabled;
  final List<String> bottles;
  final List<String> buildDependencies;
  final List<String> dependencies;
  final List<String> conflictsWith;

  Formula({
    required this.name,
    required this.version,
    required this.description,
    required this.license,
    required this.homepage,
    required this.caveats,
    required this.deprecateDate,
    required this.deprecateReason,
    required this.disableDate,
    required this.disableReason,
    required this.versionScheme,
    required this.revision,
    required this.bottleDisabled,
    required this.kegOnly,
    required this.deprecated,
    required this.disabled,
    required this.bottles,
    required this.buildDependencies,
    required this.dependencies,
    required this.conflictsWith,
  });

  String get coreTapURL =>
      'https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/$name.rb';

  factory Formula.fromJson(Map<String, dynamic> json) {
    return Formula(
      name: json['name'],
      version: json['versions']['stable'],
      description: json['desc'],
      license: json['license'] ?? '',
      homepage: json['homepage'],
      caveats: json['caveats'] ?? '',
      deprecateDate: json['deprecation_date'] ?? '',
      deprecateReason: json['deprecation_reason'] ?? '',
      disableDate: json['disable_date'] ?? '',
      disableReason: json['disable_reason'] ?? '',
      versionScheme: json['version_scheme'],
      revision: json['revision'],
      bottleDisabled: json['bottle_disabled'],
      kegOnly: json['keg_only'],
      deprecated: json['deprecated'],
      disabled: json['disabled'],
      bottles: json['bottle'].isEmpty
          ? []
          : List<String>.from(json['bottle']['stable']['files'].keys),
      buildDependencies: List<String>.from(json['build_dependencies']),
      dependencies: List<String>.from(json['dependencies']),
      conflictsWith: List<String>.from(json['conflicts_with']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'versions': {
        'stable': version,
      },
      'desc': description,
      'license': license,
      'homepage': homepage,
      'caveats': caveats,
      'deprecate_date': deprecateDate,
      'deprecate_reason': deprecateReason,
      'disable_date': disableDate,
      'disable_reason': disableReason,
      'version_scheme': versionScheme,
      'revision': revision,
      'bottle_disabled': bottleDisabled,
      'keg_only': kegOnly,
      'deprecated': deprecated,
      'disabled': disabled,
      'bottle': {
        'stable': {
          'files': Map.fromIterable(bottles, value: (_) => {}),
        },
      },
      'build_dependencies': buildDependencies,
      'dependencies': dependencies,
      'conflicts_with': conflictsWith,
    };
  }
}

extension FormulaListExtension on List<Formula> {
  Formula findFormulaByName(String name) {
    return firstWhere((formula) => formula.name == name);
  }
}
