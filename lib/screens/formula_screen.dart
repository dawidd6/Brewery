import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/widgets/chips_section.dart';
import 'package:brewery/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormulaScreen extends StatelessWidget {
  static const route = '/formula';
  final String name;

  static String routeWith(String name) => '$route/$name';

  FormulaScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FormulaeBloc>(context);
    final formulae = (bloc.state as FormulaeLoadedState).formulae;
    final formula = formulae.findFormulaByName(name);

    return Scaffold(
      appBar: AppBar(
        title: Text(formula.name),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          TextSection(header: 'Formula', body: formula.coreTapURL),
          TextSection(header: 'Description', body: formula.description),
          TextSection(header: 'Version', body: formula.version),
          if (formula.revision != 0)
            TextSection(
              header: 'Revision',
              body: formula.revision.toString(),
            ),
          if (formula.versionScheme != 0)
            TextSection(
              header: 'Version scheme',
              body: formula.versionScheme.toString(),
            ),
          TextSection(header: 'Homepage', body: formula.homepage),
          TextSection(header: 'License', body: formula.license),
          TextSection(header: 'Caveats', body: formula.caveats),
          if (formula.kegOnly)
            TextSection(
              header: 'Keg only',
              body: formula.kegOnly.toString(),
            ),
          TextSection(
            header: 'Deprecate date',
            body: formula.deprecateDate,
          ),
          TextSection(
            header: 'Deprecate reason',
            body: formula.deprecateReason,
          ),
          TextSection(
            header: 'Disable date',
            body: formula.disableDate,
          ),
          TextSection(
            header: 'Disable reason',
            body: formula.disableReason,
          ),
          if (formula.bottleDisabled)
            TextSection(
              header: 'Bottles disabled',
              body: formula.bottleDisabled.toString(),
            ),
          ChipsSection(
            header: 'Bottles',
            list: formula.bottles,
          ),
          ChipsSection(
            header: 'Build dependencies',
            list: formula.buildDependencies,
            onChipTap: (name) => Navigator.of(context).pushNamed(
              FormulaScreen.routeWith(name),
            ),
          ),
          ChipsSection(
            header: 'Dependencies',
            list: formula.dependencies,
            onChipTap: (name) => Navigator.of(context).pushNamed(
              FormulaScreen.routeWith(name),
            ),
          ),
          ChipsSection(
            header: 'Conflicts',
            list: formula.conflictsWith,
            onChipTap: (name) => Navigator.of(context).pushNamed(
              FormulaScreen.routeWith(name),
            ),
          ),
        ],
      ),
    );
  }
}
