import 'package:brewery/models/formula.dart';
import 'package:brewery/widgets/chips_section.dart';
import 'package:flutter/material.dart';

class FormulaScreen extends StatelessWidget {
  final Formula formula;
  final List<Formula> formulae;

  FormulaScreen({
    Key? key,
    required this.formula,
    required this.formulae,
  }) : super(key: key);

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
              onChipTap: (label) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormulaScreen(
                    formula: formulae.findByName(label),
                    formulae: formulae,
                  ),
                ),
              ),
            ),
            ChipsSection(
              header: 'Dependencies',
              list: formula.dependencies,
              onChipTap: (label) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormulaScreen(
                    formula: formulae.findByName(label),
                    formulae: formulae,
                  ),
                ),
              ),
            ),
            ChipsSection(
              header: 'Conflicts',
              list: formula.conflictsWith,
              onChipTap: (label) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormulaScreen(
                    formula: formulae.findByName(label),
                    formulae: formulae,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
