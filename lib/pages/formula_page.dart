import 'package:brewery/models/formula.dart';
import 'package:brewery/widgets/chips_section.dart';
import 'package:flutter/material.dart';

class FormulaPage extends StatelessWidget {
  final Formula formula;

  FormulaPage({Key? key, required this.formula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formula.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ChipsSection(
              header: 'Bottles',
              list: formula.bottles,
            ),
            ChipsSection(
              header: 'Build dependencies',
              list: formula.buildDependencies,
            ),
            ChipsSection(
              header: 'Dependencies',
              list: formula.dependencies,
            ),
            ChipsSection(
              header: 'Conflicts',
              list: formula.conflictsWith,
            ),
          ],
        ),
      ),
    );
  }
}
