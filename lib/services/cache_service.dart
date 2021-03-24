import 'dart:convert';
import 'dart:io';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class CacheService {
  static String serializeFormulae(List<Formula> formulae) {
    return jsonEncode(formulae);
  }

  static String serializeCasks(List<Cask> casks) {
    return jsonEncode(casks);
  }

  Future<File> _file(String fileName) async {
    final dir = await getTemporaryDirectory();
    return File('${dir.path}/$fileName');
  }

  Future _write(String fileName, String data) async {
    final file = await _file(fileName);
    await file.writeAsString(data);
  }

  Future<String> _read(String fileName, {bool old = false}) async {
    final file = await _file(fileName);
    final mod = file.lastModifiedSync();
    final diff = DateTime.now().difference(mod);
    if (diff > Duration(minutes: 10)) {
      if (!old) {
        throw Exception('Cache too old');
      }
    }
    return file.readAsString();
  }

  Future<List<Formula>> loadOldFormulae() async {
    return compute(
      ApiService.parseFormulae,
      await _read('formulae.json', old: true),
    );
  }

  Future<List<Cask>> loadOldCasks() async {
    return compute(
      ApiService.parseCasks,
      await _read('casks.json', old: true),
    );
  }

  Future<List<Formula>> loadFormulae() async {
    return compute(
      ApiService.parseFormulae,
      await _read('formulae.json'),
    );
  }

  Future<List<Cask>> loadCasks() async {
    return compute(
      ApiService.parseCasks,
      await _read('casks.json'),
    );
  }

  Future<List<Formula>> saveFormulae(List<Formula> formulae) async {
    await _write(
      'formulae.json',
      await compute(serializeFormulae, formulae),
    );
    return formulae;
  }

  Future<List<Cask>> saveCasks(List<Cask> casks) async {
    await _write(
      'casks.json',
      await compute(serializeCasks, casks),
    );
    return casks;
  }
}
