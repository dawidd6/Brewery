import 'package:brewery/blocs/formula/formula_bloc.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/chips_section.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: BlocBuilder<FormulaBloc, FormulaState>(
        builder: (context, state) => CenterSwitcher(
          builder: (context) {
            if (state is FormulaLoadedState) {
              return ListView(
                padding: EdgeInsets.all(20.0),
                children: [
                  TextSection(
                      header: 'Formula', body: state.formula.coreTapURL),
                  TextSection(
                      header: 'Description', body: state.formula.description),
                  TextSection(header: 'Version', body: state.formula.version),
                  if (state.formula.revision != 0)
                    TextSection(
                      header: 'Revision',
                      body: state.formula.revision.toString(),
                    ),
                  if (state.formula.versionScheme != 0)
                    TextSection(
                      header: 'Version scheme',
                      body: state.formula.versionScheme.toString(),
                    ),
                  TextSection(header: 'Homepage', body: state.formula.homepage),
                  TextSection(header: 'License', body: state.formula.license),
                  TextSection(header: 'Caveats', body: state.formula.caveats),
                  if (state.formula.kegOnly)
                    TextSection(
                      header: 'Keg only',
                      body: state.formula.kegOnly.toString(),
                    ),
                  TextSection(
                    header: 'Deprecate date',
                    body: state.formula.deprecateDate,
                  ),
                  TextSection(
                    header: 'Deprecate reason',
                    body: state.formula.deprecateReason,
                  ),
                  TextSection(
                    header: 'Disable date',
                    body: state.formula.disableDate,
                  ),
                  TextSection(
                    header: 'Disable reason',
                    body: state.formula.disableReason,
                  ),
                  if (state.formula.bottleDisabled)
                    TextSection(
                      header: 'Bottles disabled',
                      body: state.formula.bottleDisabled.toString(),
                    ),
                  ChipsSection(
                    header: 'Bottles',
                    list: state.formula.bottles,
                  ),
                  ChipsSection(
                    header: 'Build dependencies',
                    list: state.formula.buildDependencies,
                    onChipTap: (name) => Navigator.of(context).pushNamed(
                      FormulaScreen.routeWith(name),
                    ),
                  ),
                  ChipsSection(
                    header: 'Dependencies',
                    list: state.formula.dependencies,
                    onChipTap: (name) => Navigator.of(context).pushNamed(
                      FormulaScreen.routeWith(name),
                    ),
                  ),
                  ChipsSection(
                    header: 'Conflicts',
                    list: state.formula.conflictsWith,
                    onChipTap: (name) => Navigator.of(context).pushNamed(
                      FormulaScreen.routeWith(name),
                    ),
                  ),
                ],
              );
            } else if (state is FormulaErrorState) {
              return FailureText(
                error: state.error,
              );
            }
            return LoadingIcon();
          },
        ),
      ),
    );
  }
}
