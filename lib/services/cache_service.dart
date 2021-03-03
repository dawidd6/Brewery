import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheService {
  Future<File> write(String data, String endpoint) async {
    var cacheDirPath = await getTemporaryDirectory();
    var filePath = cacheDirPath.path + endpoint;
    var file = File(filePath);
    return file.writeAsString(data);
  }

  Future<String?> read(String endpoint, {ignoreOld = false}) async {
    var cacheDirPath = await getTemporaryDirectory();
    var filePath = cacheDirPath.path + endpoint;
    var file = File(filePath);
    var mod = file.lastModifiedSync();
    var diff = DateTime.now().difference(mod);
    if (diff > Duration(minutes: 10) && !ignoreOld) {
      return null;
    }
    return file.readAsString();
  }
}
