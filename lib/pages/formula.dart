import 'package:brewery/models/formula.dart';
import 'package:flutter/material.dart';

class BreweryFormulaPage extends StatelessWidget {
  final Formula formula;

  BreweryFormulaPage({Key key, @required this.formula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formula.name),
      ),
      body: Placeholder(),
    );
  }
}
