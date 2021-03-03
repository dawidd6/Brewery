import 'dart:async';
import 'dart:convert';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiService {
  final String baseURL = 'https://formulae.brew.sh/api';
  final String formulaeEndpoint = '/formula.json';
  final String formulaeLinuxEndpoint = '/formula-linux.json';
  final String casksEndpoint = '/cask.json';
  final Duration timeout = Duration(seconds: 15);
  final Client client;

  ApiService({
    required this.client,
  });

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
    final response =
        await get(Uri.parse(baseURL + formulaeEndpoint)).timeout(timeout);

    if (response.statusCode == 200) {
      return compute(parseFormulae, response.body);
    }

    throw Exception('Failed to fetch formulae');
  }

  Future<List<Cask>> fetchCasks({cache = true}) async {
    final response =
        await get(Uri.parse(baseURL + casksEndpoint)).timeout(timeout);

    if (response.statusCode == 200) {
      return compute(parseCasks, response.body);
    }

    throw Exception('Failed to fetch formulae');
  }
}
