import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/filtered_casks/filtered_casks_bloc.dart';
import 'package:brewery/blocs/filtered_formulae/filtered_formulae_bloc.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/blocs/settings/settings_bloc.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:brewery/screens/home_screen.dart';
import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsBloc(),
          ),
          BlocProvider(
            create: (context) => FormulaeBloc(
              repository: RepositoryProvider.of<ApiRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => CasksBloc(
              repository: RepositoryProvider.of<ApiRepository>(context),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FilteredFormulaeBloc(
                bloc: BlocProvider.of<FormulaeBloc>(context),
              ),
            ),
            BlocProvider(
              create: (context) => FilteredCasksBloc(
                bloc: BlocProvider.of<CasksBloc>(context),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Brewery',
            theme: BreweryTheme.data,
            home: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
