import 'package:brewery/blocs/casks_bloc.dart';
import 'package:brewery/pages/home_page.dart';
import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Brewery",
      theme: BreweryTheme.data,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CasksBloc()),
        ],
        child: HomePage(),
      ),
    );
  }
}
