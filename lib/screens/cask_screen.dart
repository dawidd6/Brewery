import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/screens/formula_screen.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/chips_section.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaskScreen extends StatelessWidget {
  final String token;

  CaskScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CasksBloc>(context);
    final casks = (bloc.state as CasksLoadedState).casks;
    final cask = casks.findCaskByToken(token);

    return Scaffold(
      appBar: AppBar(
        title: Text(cask.token),
      ),
      body: BlocBuilder<FormulaeBloc, FormulaeState>(
        builder: (context, formulaeState) => BlocBuilder<CasksBloc, CasksState>(
          builder: (context, casksState) => CenterSwitcher(
            builder: (context) {
              if (formulaeState is FormulaeLoadedState &&
                  casksState is CasksLoadedState) {
                return ListView(
                  padding: EdgeInsets.all(20.0),
                  children: [
                    TextSection(header: 'Alias', body: cask.name),
                    TextSection(header: 'Description', body: cask.description),
                    TextSection(header: 'Homepage', body: cask.homepage),
                    TextSection(header: 'Version', body: cask.version),
                    TextSection(header: 'Caveats', body: cask.caveats),
                    TextSection(
                      header: 'Needs macOS',
                      body: cask.dependsOnMacOS,
                    ),
                    ChipsSection(
                      header: 'Formula dependencies',
                      list: cask.dependsOnFormulae,
                      onChipTap: (name) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormulaScreen(
                            name: name,
                          ),
                        ),
                      ),
                    ),
                    ChipsSection(
                      header: 'Cask dependencies',
                      list: cask.dependsOnCasks,
                      clickableIf: casksState.casks.isCaskPresent,
                      onChipTap: (token) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaskScreen(
                            token: token,
                          ),
                        ),
                      ),
                    ),
                    ChipsSection(
                      header: 'Formula conflicts',
                      list: cask.conflictsWithFormulae,
                      onChipTap: (name) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormulaScreen(
                            name: name,
                          ),
                        ),
                      ),
                    ),
                    ChipsSection(
                      header: 'Cask conflicts',
                      list: cask.conflictsWithCasks,
                      clickableIf: casksState.casks.isCaskPresent,
                      onChipTap: (token) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaskScreen(
                            token: token,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (formulaeState is FormulaeErrorState ||
                  casksState is CasksErrorState) {
                final error = formulaeState is FormulaeErrorState
                    ? formulaeState.error
                    : (casksState as CasksErrorState).error;
                return FailureText(
                  message: error.toString(),
                );
              } else if (formulaeState is FormulaeLoadingState ||
                  casksState is CasksLoadingState) {
                return LoadingIcon();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
