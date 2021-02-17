import 'dart:convert';

import 'package:brewery/models/formula.dart';
import 'package:http/http.dart' as http;

class API {
  final String baseURL = "https://formulae.brew.sh/api";
  final String formulaEndpoint = "/formula.json";
  final String formulaLinuxEndpoint = "/formula-linux.json";
  final String caskEndpoint = "/cask.json";

  Future<List<Formula>> fetchFormula() async {
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
}
