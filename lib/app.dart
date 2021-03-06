import 'package:brewery/blocs/casks_bloc.dart';
import 'package:brewery/blocs/formulae_bloc.dart';
import 'package:brewery/blocs/home_bloc.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:brewery/screens/home_screen.dart';
import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brewery',
      theme: BreweryTheme.data,
      home: RepositoryProvider(
        create: (context) => ApiRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeBloc(),
            ),
            BlocProvider(
              create: (context) => FormulaeBloc(
                repository: RepositoryProvider.of<ApiRepository>(context),
              )..add(FormulaeRequestEvent()),
            ),
            BlocProvider(
              create: (context) => CasksBloc(
                repository: RepositoryProvider.of<ApiRepository>(context),
              )..add(CasksRequestEvent()),
            ),
          ],
          child: HomeScreen(),
        ),
      ),
    );
  }
}
