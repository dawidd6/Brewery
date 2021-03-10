import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/cache_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiService {
  final String baseURL = 'https://formulae.brew.sh/api';
  final String formulaeEndpoint = '/formula.json';
  final String formulaeLinuxEndpoint = '/formula-linux.json';
  final String casksEndpoint = '/cask.json';
  final Duration timeout = Duration(seconds: 10);
  final CacheService cache = CacheService();

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

  Future<String?> _fetchResponseBody(String endpoint) async {
    final uri = Uri.parse(baseURL + endpoint);
    try {
      final response = await get(uri).timeout(timeout);
      if (response.statusCode == 200) {
        return response.body;
      }
    } on SocketException {
      return null;
    } on TimeoutException {
      return null;
    }
    return null;
  }

  Future<String> _fetchResponseBodyWithCache(String endpoint) async {
    String? responseBody;

    responseBody = await cache.read(endpoint);
    if (responseBody != null) {
      print('$endpoint: local hit');
      return responseBody;
    }
    print('$endpoint: local miss');

    responseBody = await _fetchResponseBody(endpoint);
    if (responseBody != null) {
      await cache.write(responseBody, endpoint);
      print('$endpoint: remote hit');
      return responseBody;
    }
    print('$endpoint: remote miss');

    responseBody = await cache.read(endpoint, ignoreOld: true);
    if (responseBody != null) {
      print('$endpoint: local hit (old)');
      return responseBody;
    }
    print('$endpoint: local miss (old)');

    throw Exception('Failed to fetch data');
  }

  Future<List<Formula>> fetchFormulae() async {
    final responseBody = await _fetchResponseBodyWithCache(formulaeEndpoint);
    return compute(parseFormulae, responseBody);
  }

  Future<List<Cask>> fetchCasks() async {
    final responseBody = await _fetchResponseBodyWithCache(casksEndpoint);
    return compute(parseCasks, responseBody);
  }
}
