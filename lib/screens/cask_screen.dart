import 'package:brewery/blocs/cask/cask_bloc.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:brewery/screens/formula_screen.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/chips_section.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaskScreen extends StatelessWidget {
  static const route = '/cask';
  final String token;

  static String routeWith(String token) => '$route/$token';

  CaskScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(token),
      ),
      body: BlocProvider(
        create: (context) => CaskBloc(
          repository: RepositoryProvider.of<ApiRepository>(context),
        )..add(CaskLoadEvent(token: token)),
        child: BlocBuilder<CaskBloc, CaskState>(
          builder: (context, state) => CenterSwitcher(
            builder: (context) {
              if (state is CaskLoadedState) {
                return ListView(
                  padding: EdgeInsets.all(20.0),
                  children: [
                    TextSection(header: 'Cask', body: state.cask.coreTapURL),
                    TextSection(header: 'Alias', body: state.cask.name),
                    TextSection(
                        header: 'Description', body: state.cask.description),
                    TextSection(header: 'Homepage', body: state.cask.homepage),
                    TextSection(header: 'Version', body: state.cask.version),
                    TextSection(header: 'Caveats', body: state.cask.caveats),
                    TextSection(
                      header: 'Auto updates',
                      body: state.cask.autoUpdates.toString(),
                    ),
                    TextSection(
                      header: 'Needs macOS',
                      body: state.cask.dependsOnMacOS,
                    ),
                    ChipsSection(
                      header: 'Formula dependencies',
                      list: state.cask.dependsOnFormulae,
                      onChipTap: (name) => Navigator.of(context).pushNamed(
                        FormulaScreen.routeWith(name),
                      ),
                    ),
                    ChipsSection(
                      header: 'Cask dependencies',
                      list: state.cask.dependsOnCasks,
                      clickableIf: (token) => !token.contains('/'),
                      onChipTap: (token) => Navigator.of(context).pushNamed(
                        CaskScreen.routeWith(token),
                      ),
                    ),
                    ChipsSection(
                      header: 'Formula conflicts',
                      list: state.cask.conflictsWithFormulae,
                      onChipTap: (name) => Navigator.of(context).pushNamed(
                        FormulaScreen.routeWith(name),
                      ),
                    ),
                    ChipsSection(
                      header: 'Cask conflicts',
                      list: state.cask.conflictsWithCasks,
                      clickableIf: (token) => !token.contains('/'),
                      onChipTap: (token) => Navigator.of(context).pushNamed(
                        CaskScreen.routeWith(token),
                      ),
                    ),
                  ],
                );
              } else if (state is CaskErrorState) {
                return FailureText(
                  error: state.error,
                );
              }
              return LoadingIcon();
            },
          ),
        ),
      ),
    );
  }
}
