import 'dart:convert';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseURL = "https://formulae.brew.sh/api";
  static final String formulaeEndpoint = "/formula.json";
  static final String formulaeLinuxEndpoint = "/formula-linux.json";
  static final String casksEndpoint = "/cask.json";

  static List<Formula> parseFormulae(String body) {
    List<dynamic> json = jsonDecode(body);

    return List.generate(
      json.length,
      (index) => Formula.fromJson(json[index]),
    );
  }

  static List<Cask> parseCasks(String body) {
    List<dynamic> json = jsonDecode(body);

    return List.generate(
      json.length,
      (index) => Cask.fromJson(json[index]),
    );
  }

  static Future<List<Formula>> fetchFormulae() async {
    print("Fetching formulae");

    final response = await http.get(baseURL + formulaeEndpoint);
    //final responseLinux = await http.get(baseURL + formulaLinuxEndpoint);

    if (response.statusCode == 200) {
      return compute(parseFormulae, response.body);
    }

    throw Exception("Failed to load formulae");
  }

  static Future<List<Cask>> fetchCasks() async {
    print("Fetching casks");

    final response = await http.get(baseURL + casksEndpoint);

    if (response.statusCode == 200) {
      return compute(parseCasks, response.body);
    }

    throw Exception("Failed to load casks");
  }
}
