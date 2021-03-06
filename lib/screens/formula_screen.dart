import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/widgets/chips_section.dart';
import 'package:brewery/widgets/link_section.dart';
import 'package:brewery/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormulaScreen extends StatelessWidget {
  final Formula formula;

  FormulaScreen({
    Key? key,
    required this.formula,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FormulaeBloc>(context);
    final formulae = (bloc.state as FormulaeLoadedState).formulae;

    return Scaffold(
      appBar: AppBar(
        title: Text(formula.name),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          LinkSection(header: 'Homepage', link: formula.homepage),
          TextSection(header: 'License', body: formula.license),
          TextSection(header: 'Description', body: formula.description),
          TextSection(header: 'Version', body: formula.version),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
