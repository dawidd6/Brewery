import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Cache {
  getCacheDir() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
  }
}
