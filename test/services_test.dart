import 'dart:io';

import 'package:brewery/services/api_service.dart';
import 'package:brewery/services/cache_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('JSON formulae parsing and serialization', () async {
    final file = File('test/fixtures/formulae.json');
    final contents = await file.readAsString();
    final formulae = ApiService.parseFormulae(contents);
    final json = CacheService.serializeFormulae(formulae);
    expect(formulae, isNotEmpty);
    expect(json, isNotEmpty);
  });

  test('JSON casks parsing and serialization', () async {
    final file = File('test/fixtures/casks.json');
    final contents = await file.readAsString();
    final casks = ApiService.parseCasks(contents);
    final json = CacheService.serializeCasks(casks);
    expect(casks, isNotEmpty);
    expect(json, isNotEmpty);
  });
}
