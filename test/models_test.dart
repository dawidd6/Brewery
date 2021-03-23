import 'dart:convert';
import 'dart:io';

import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('JSON formula parsing and serialization', () async {
    final file = File('test/fixtures/formula.json');
    final contents = await file.readAsString();
    final json = jsonDecode(contents);
    final formula = Formula.fromJson(json);
    final formula2 = Formula.fromJson(formula.toJson());
    expect(formula.name, formula2.name);
  });

  test('JSON cask parsing and serialization', () async {
    final file = File('test/fixtures/cask.json');
    final contents = await file.readAsString();
    final json = jsonDecode(contents);
    final cask = Cask.fromJson(json);
    final cask2 = Cask.fromJson(cask.toJson());
    expect(cask.name, cask2.name);
  });
}
