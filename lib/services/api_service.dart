import 'dart:convert';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/cache_service.dart';
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

  static Future<List<dynamic>> _fetchObjects(
      Function parseFunction, String endpoint) async {
    try {
      print("$endpoint: trying cache");
      final data = await CacheService.read(endpoint);
      print("$endpoint: cache hit");
      return compute(parseFunction, data);
    } catch (exception) {
      print("$endpoint: calling api");
      final response = await http.get(baseURL + endpoint);
      print("$endpoint: got response from api");
      if (response.statusCode == 200) {
        print("$endpoint: saving cache");
        await CacheService.write(response.body, endpoint);
        print("$endpoint: cache saved");
        return compute(parseFunction, response.body);
      }
    }

    throw Exception();
  }

  static Future<List<Formula>> fetchFormulae() async {
    return await _fetchObjects(parseFormulae, formulaeEndpoint);
  }

  static Future<List<Cask>> fetchCasks() async {
    return await _fetchObjects(parseCasks, casksEndpoint);
  }
}
