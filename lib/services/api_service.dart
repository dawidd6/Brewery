import 'dart:async';
import 'dart:convert';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiService {
  static const baseURL = 'https://formulae.brew.sh/api';
  final _timeout = Duration(seconds: 30);

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

  Future<List<Formula>> fetchFormulae() async {
    final endpoint = '/formula.json';
    final uri = Uri.parse(baseURL + endpoint);
    final response = await get(uri).timeout(_timeout);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch formulae');
    }
    return compute(parseFormulae, response.body);
  }

  Future<List<Cask>> fetchCasks() async {
    final endpoint = '/cask.json';
    final uri = Uri.parse(baseURL + endpoint);
    final response = await get(uri).timeout(_timeout);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch casks');
    }
    return compute(parseCasks, response.body);
  }
}
