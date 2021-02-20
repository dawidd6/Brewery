import 'package:brewery/models/formula.dart';
import 'package:flutter/material.dart';

class FormulaPage extends StatelessWidget {
  final Formula formula;

  FormulaPage({Key key, @required this.formula}) : super(key: key);

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
