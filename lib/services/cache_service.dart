import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheTooOldException implements Exception {
  CacheTooOldException();
}

class CacheService {
  static Future write(String data, String endpoint) async {
    var cacheDirPath = await getTemporaryDirectory();
    var filePath = cacheDirPath.path + endpoint;
    var file = File(filePath);
    return file.writeAsString(data);
  }

  static Future<String> read(String endpoint, {ignoreOld = false}) async {
    var cacheDirPath = await getTemporaryDirectory();
    var filePath = cacheDirPath.path + endpoint;
    var file = File(filePath);
    var mod = file.lastModifiedSync();
    var diff = DateTime.now().difference(mod);
    if (diff > Duration(minutes: 10) && !ignoreOld)
      throw CacheTooOldException();
    return file.readAsString();
  }
}
