import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/widgets/chips_section.dart';
import 'package:brewery/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vrouter/vrouter.dart';

class FormulaScreen extends StatelessWidget {
  FormulaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = VRouteElementData.of(context).pathParameters['name']!;
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
          TextSection(header: 'Description', body: formula.description),
          TextSection(header: 'Version', body: formula.version),
          TextSection(header: 'Homepage', body: formula.homepage),
          TextSection(header: 'License', body: formula.license),
          TextSection(header: 'Caveats', body: formula.caveats),
          ChipsSection(
            header: 'Bottles',
            list: formula.bottles,
          ),
          ChipsSection(
            header: 'Build dependencies',
            list: formula.buildDependencies,
            onChipTap: (name) => VRouterData.of(context).push('/formula/$name'),
          ),
          ChipsSection(
            header: 'Dependencies',
            list: formula.dependencies,
            onChipTap: (name) => VRouterData.of(context).push('/formula/$name'),
          ),
          ChipsSection(
            header: 'Conflicts',
            list: formula.conflictsWith,
            onChipTap: (name) => VRouterData.of(context).push('/formula/$name'),
          ),
        ],
      ),
    );
  }
}
