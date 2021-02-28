import 'dart:convert';
import 'dart:io';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/cache_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SkipCacheException {
  SkipCacheException();
}

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
      Function parseFunction, String endpoint,
      [bool cache = true]) async {
    try {
      if (cache == false) throw SkipCacheException();

      print("$endpoint: trying cache");
      final data = await CacheService.read(endpoint);
      print("$endpoint: cache hit");

      return compute(parseFunction, data);
    } catch (exception) {
      if (exception is SkipCacheException)
        print("$endpoint: skipping cache as desired");
      else if (exception is CacheTooOldException)
        print("$endpoint: cache is too old");
      else if (exception is FileSystemException)
        print("$endpoint: cache reading failed");
      else
        rethrow;

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

  static Future<List<Formula>> fetchFormulae({cache = true}) async {
    return await _fetchObjects(parseFormulae, formulaeEndpoint, cache);
  }

  static Future<List<Cask>> fetchCasks({cache = true}) async {
    return await _fetchObjects(parseCasks, casksEndpoint, cache);
  }
}