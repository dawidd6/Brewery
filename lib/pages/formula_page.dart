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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "name:",
                ),
                Text(
                  formula.name,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "description:",
                ),
                Text(
                  formula.description,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
