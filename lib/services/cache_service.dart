import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class CacheService {
  Future<File?> write(String data, String endpoint) async {
    if (kIsWeb) {
      return null;
    }
    var cacheDirPath = await getTemporaryDirectory();
    var filePath = cacheDirPath.path + endpoint;
    var file = File(filePath);
    return file.writeAsString(data);
  }

  Future<String> read(String endpoint, {ignoreOld = false}) async {
    if (kIsWeb) {
      return '';
    }
    var cacheDirPath = await getTemporaryDirectory();
    var filePath = cacheDirPath.path + endpoint;
    var file = File(filePath);
    if (file.existsSync()) {
      var mod = file.lastModifiedSync();
      var diff = DateTime.now().difference(mod);
      if (diff > Duration(minutes: 10) && !ignoreOld) {
        return '';
      }
      return file.readAsString();
    }
    return '';
  }
}
