import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class CacheService {
  Future<File> _file(String endpoint) async {
    final dir = await getTemporaryDirectory();
    return File(dir.path + endpoint);
  }

  Future<File?> write(String data, String endpoint) async {
    if (kIsWeb) {
      return null;
    }

    return (await _file(endpoint)).writeAsString(data);
  }

  Future<String?> read(String endpoint, {ignoreOld = false}) async {
    if (kIsWeb) {
      return null;
    }

    final file = await _file(endpoint);

    if (!file.existsSync()) {
      return null;
    }

    final mod = file.lastModifiedSync();
    final diff = DateTime.now().difference(mod);

    if (diff > Duration(minutes: 10) && !ignoreOld) {
      return null;
    }

    return file.readAsString();
  }
}
