import 'dart:convert';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:http/http.dart' as http;

class API {
  static final String baseURL = "https://formulae.brew.sh/api";
  static final String formulaeEndpoint = "/formula.json";
  static final String formulaeLinuxEndpoint = "/formula-linux.json";
  static final String casksEndpoint = "/cask.json";

  static Future<List<Formula>> fetchFormulae() async {
    await Future.delayed(Duration(seconds: 3));
    return Future.error("Failed to load formulae");

    final response = await http.get(baseURL + formulaeEndpoint);
    //final responseLinux = await http.get(baseURL + formulaLinuxEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);

      return List.generate(
        json.length,
        (index) => Formula.fromJson(json[index]),
      );
    }

    return Future.error("Failed to load formulae");
  }

  static Future<List<Cask>> fetchCasks() async {
    final response = await http.get(baseURL + casksEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);

      return List.generate(
        json.length,
        (index) => Cask.fromJson(json[index]),
      );
    }

    return Future.error("Failed to load casks");
  }
}
