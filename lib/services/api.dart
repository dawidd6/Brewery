import 'dart:convert';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:http/http.dart' as http;

class API {
  static final String baseURL = "https://formulae.brew.sh/api";
  static final String formulaEndpoint = "/formula.json";
  static final String formulaLinuxEndpoint = "/formula-linux.json";
  static final String caskEndpoint = "/cask.json";

  static Future<List<Formula>> fetchFormula() async {
    final response = await http.get(baseURL + formulaEndpoint);
    //final responseLinux = await http.get(baseURL + formulaLinuxEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      return List.generate(
        json.length,
        (index) => Formula.fromJson(json[index]),
      );
    } else {
      throw Exception('Failed to load formula');
    }
  }

  static Future<List<Cask>> fetchCask() async {
    final response = await http.get(baseURL + caskEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      return List.generate(
        json.length,
        (index) => Cask.fromJson(json[index]),
      );
    } else {
      throw Exception('Failed to load cask');
    }
  }
}
