import 'package:brewery/models/cask.dart';
import 'package:brewery/pages/cask.dart';
import 'package:brewery/pages/formulae.dart';
import 'package:brewery/services/api.dart';
import 'package:flutter/material.dart';

class CasksPage extends FormulaePage {
  static final String name = "Casks";

  CasksPage({Key key}) : super(key: key);

  @override
  CasksPageState createState() => CasksPageState();
}

class CasksPageState extends FormulaePageState {
  @override
  Future refresh() => futureList = API.fetchCasks();

  @override
  Widget page(dynamic obj) => CaskPage(cask: obj);

  @override
  String trailing(dynamic obj) => (obj as Cask).version;

  @override
  String subtitle(dynamic obj) => (obj as Cask).description;

  @override
  String title(dynamic obj) => (obj as Cask).token;
}
