import 'dart:convert';
import 'dart:io';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/api.dart';
import 'package:path_provider/path_provider.dart';

class Cache {
  Future<File> writeCasks(List<Cask> casks) async {
    var cacheDirPath = await getCacheDirPath();
    var filePath = cacheDirPath + API.casksEndpoint;
    var file = File(filePath);
    return file.writeAsString(jsonEncode(casks));
  }

  Future<File> writeFormulae(List<Formula> formulae) async {
    var cacheDirPath = await getCacheDirPath();
    var filePath = cacheDirPath + API.formulaeEndpoint;
    var file = File(filePath);
    return file.writeAsString(jsonEncode(formulae));
  }

  Future<List<Cask>> readCasks() async {
    var cacheDirPath = await getCacheDirPath();
    var filePath = cacheDirPath + API.casksEndpoint;
    var file = File(filePath);
    var contents = await file.readAsString();
    return jsonDecode(contents);
  }

  Future<List<Formula>> readFormulae() async {
    var cacheDirPath = await getCacheDirPath();
    var filePath = cacheDirPath + API.formulaeEndpoint;
    var file = File(filePath);
    var contents = await file.readAsString();
    return jsonDecode(contents);
  }

  Future<String> getCacheDirPath() async {
    var dir = await getTemporaryDirectory();
    return dir.path;
  }
}
