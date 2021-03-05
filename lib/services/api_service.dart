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
  final Duration timeout = Duration(seconds: 15);
  final CacheService cache = CacheService();
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
    var response = Response(await cache.read(formulaeEndpoint), 200);

    if (response.body.isEmpty) {
      try {
        response = await client
            .get(Uri.parse(baseURL + formulaeEndpoint))
            .timeout(timeout);
        if (response.statusCode == 200) {
          await cache.write(response.body, formulaeEndpoint);
        }
      } on SocketException {
        response =
            Response(await cache.read(formulaeEndpoint, ignoreOld: true), 200);
        if (response.body.isEmpty) {
          rethrow;
        }
      }
    }

    return compute(parseFormulae, response.body);
  }

  Future<List<Cask>> fetchCasks() async {
    var response = Response(await cache.read(casksEndpoint), 200);

    if (response.body.isEmpty) {
      try {
        response = await client
            .get(Uri.parse(baseURL + casksEndpoint))
            .timeout(timeout);
        if (response.statusCode == 200) {
          await cache.write(response.body, casksEndpoint);
        }
      } on SocketException {
        response =
            Response(await cache.read(casksEndpoint, ignoreOld: true), 200);
        if (response.body.isEmpty) {
          rethrow;
        }
      }
    }

    return compute(parseCasks, response.body);
  }
}
