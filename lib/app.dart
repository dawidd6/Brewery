import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/filtered_casks/filtered_casks_bloc.dart';
import 'package:brewery/blocs/filtered_formulae/filtered_formulae_bloc.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/blocs/settings/settings_cubit.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:brewery/screens/cask_screen.dart';
import 'package:brewery/screens/casks_screen.dart';
import 'package:brewery/screens/formula_screen.dart';
import 'package:brewery/screens/formulae_screen.dart';
import 'package:brewery/screens/home_screen.dart';
import 'package:brewery/screens/settings_screen.dart';
import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:vrouter/vrouter.dart';

class App extends StatelessWidget {
  List<VRouteElement> get routes => [
        VStacked(
          path: '/',
          widget: HomeScreen(),
          subroutes: [
            VStacked(
              path: '/formulae',
              widget: FormulaeScreen(),
              subroutes: [
                VStacked(
                  path: '/formula/:name',
                  widget: FormulaScreen(),
                ),
              ],
            ),
            VStacked(
              path: '/casks',
              widget: CasksScreen(),
              subroutes: [
                VStacked(
                  path: '/cask/:token',
                  widget: CaskScreen(),
                ),
              ],
            ),
            VStacked(
              path: '/settings',
              widget: SettingsScreen(),
            ),
          ],
        ),
      ];

  AnimatedWidget pageTransition(
    Animation<double> animation,
    Animation<double> secondAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween(
          begin: Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

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
            child: VRouter(
              title: 'Brewery',
              theme: BreweryTheme.data,
              mode: VRouterModes.history,
              routes: routes,
              buildTransition: pageTransition,
            ),
          ),
        ),
      ),
    );
  }
}
