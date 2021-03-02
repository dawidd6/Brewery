import 'package:brewery/blocs/casks_bloc.dart';
import 'package:brewery/blocs/formulae_bloc.dart';
import 'package:brewery/blocs/home_bloc.dart';
import 'package:brewery/blocs/settings_bloc.dart';
import 'package:brewery/pages/home_page.dart';
import 'package:brewery/pages/settings_page.dart';
import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Brewery",
      theme: BreweryTheme.data,
      routes: {
        HomePage.route: (context) => MultiBlocProvider(
              child: HomePage(),
              providers: [
                BlocProvider(
                  create: (context) => HomeBloc(),
                ),
                BlocProvider(
                  create: (context) => CasksBloc(),
                ),
                BlocProvider(
                  create: (context) => FormulaeBloc(),
                ),
              ],
            ),
        SettingsPage.route: (context) => BlocProvider(
              child: SettingsPage(),
              create: (context) => SettingsBloc(),
            )
      },
    );
  }
}
