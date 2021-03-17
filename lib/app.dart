import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/filtered_casks/filtered_casks_bloc.dart';
import 'package:brewery/blocs/filtered_formulae/filtered_formulae_bloc.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/blocs/settings/settings_cubit.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:brewery/screens/cask_screen.dart';
import 'package:brewery/screens/casks_screen.dart';
import 'package:brewery/screens/formula_screen.dart';
import 'package:brewery/screens/formulae_casks_screen.dart';
import 'package:brewery/screens/formulae_screen.dart';
import 'package:brewery/screens/home_screen.dart';
import 'package:brewery/screens/settings_screen.dart';
import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsTestCubit(),
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
          child: KeyboardDismisser(
            child: MaterialApp(
              title: 'Brewery',
              theme: BreweryTheme.data,
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == null || settings.name == '/') {
                  return MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                    settings: settings,
                  );
                } else if (settings.name == '/settings') {
                  return MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                    settings: settings,
                  );
                } else if (settings.name == '/formulae_casks') {
                  return MaterialPageRoute(
                    builder: (context) => FormulaeCasksScreen(),
                    settings: settings,
                  );
                } else if (settings.name == '/formulae') {
                  return MaterialPageRoute(
                    builder: (context) => FormulaeScreen(),
                    settings: settings,
                  );
                } else if (settings.name == '/casks') {
                  return MaterialPageRoute(
                    builder: (context) => CasksScreen(),
                    settings: settings,
                  );
                } else if (settings.name!.startsWith('/formula/')) {
                  final uri = Uri.parse(settings.name!);
                  if (uri.pathSegments.length == 2) {
                    return MaterialPageRoute(
                      builder: (context) => FormulaScreen(
                        name: uri.pathSegments.last,
                      ),
                      settings: settings,
                    );
                  }
                } else if (settings.name!.startsWith('/cask/')) {
                  final uri = Uri.parse(settings.name!);
                  if (uri.pathSegments.length == 2) {
                    return MaterialPageRoute(
                      builder: (context) => CaskScreen(
                        token: uri.pathSegments.last,
                      ),
                      settings: settings,
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
