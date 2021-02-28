import 'package:flutter/foundation.dart';

class Formula {
  final String name;
  final String version;
  final String versionScheme;
  final String revision;
  final String description;
  final String license;
  final String homepage;
  final String caveats;
  final String deprecateDate;
  final String deprecateReason;
  final String disableDate;
  final String disableReason;
  final bool bottleDisabled;
  final bool kegOnly;
  final bool deprecated;
  final bool disabled;
  final List<String> bottles;
  final List<String> buildDependencies;
  final List<String> dependencies;
  final List<String> usesFromMacOS;
  final List<String> requirements;
  final List<String> conflictsWith;

  Formula({
    @required this.name,
    @required this.version,
    @required this.versionScheme,
    @required this.revision,
    @required this.description,
    @required this.license,
    @required this.homepage,
    @required this.caveats,
    @required this.deprecateDate,
    @required this.deprecateReason,
    @required this.disableDate,
    @required this.disableReason,
    @required this.bottleDisabled,
    @required this.kegOnly,
    @required this.deprecated,
    @required this.disabled,
    @required this.bottles,
    @required this.buildDependencies,
    @required this.dependencies,
    @required this.usesFromMacOS,
    @required this.requirements,
    @required this.conflictsWith,
  });

  factory Formula.fromJson(Map<String, dynamic> json) {
    return Formula(
      name: json["name"],
      version: json["versions"]["stable"],
      versionScheme: json["version_scheme"],
      revision: json["revision"],
      description: json["desc"],
      license: json["license"],
      homepage: json["homepage"],
      caveats: json["caveats"] ?? "",
      deprecateDate: json["deprecate_date"] ?? "",
      deprecateReason: json["deprecate_reason"] ?? "",
      disableDate: json["disable_date"] ?? "",
      disableReason: json["disable_reason"] ?? "",
      bottleDisabled: json["bottle_disabled"],
      kegOnly: json["keg_only"],
      deprecated: json["deprecated"],
      disabled: json["disabled"],
      bottles: json["bottle_disabled"]
          ? []
          : (json["bottle"]["stable"]["files"] as Map<String, Object>)
              .keys
              .toList(),
      buildDependencies: json["build_dependencies"],
      dependencies: json["dependencies"],
      usesFromMacOS: json["uses_from_macos"],
      requirements: json["requirements"],
      conflictsWith: json["conflicts_with"],
    );
  }
}
