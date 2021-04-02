import 'package:brewery/blocs/cask/cask_bloc.dart';
import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/completions/completions_bloc.dart';
import 'package:brewery/blocs/filtered_casks/filtered_casks_bloc.dart';
import 'package:brewery/blocs/filtered_formulae/filtered_formulae_bloc.dart';
import 'package:brewery/blocs/formula/formula_bloc.dart';
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
import 'package:brewery/services/api_service.dart';
import 'package:brewery/services/cache_service.dart';
import 'package:brewery/services/cache_service_web.dart';
import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class App extends StatelessWidget {
  final _nav = GlobalKey<NavigatorState>();

  App() {
    Keybinder.bind(
      Keybinding.from([
        LogicalKeyboardKey.escape,
      ]),
      () => _nav.currentState?.maybePop(),
    );
  }

  Route<dynamic>? _routes(RouteSettings settings) {
    if (settings.name == HomeScreen.route) {
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
        settings: settings,
      );
    } else if (settings.name == SettingsScreen.route) {
      return MaterialPageRoute(
        builder: (context) => SettingsScreen(),
        settings: settings,
      );
    } else if (settings.name == FormulaeCasksScreen.route) {
      return MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
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
          child: FormulaeCasksScreen(),
        ),
        settings: settings,
      );
    } else if (settings.name == FormulaeScreen.route) {
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => FilteredFormulaeBloc(
            bloc: BlocProvider.of<FormulaeBloc>(context),
          ),
          child: FormulaeScreen(),
        ),
        settings: settings,
      );
    } else if (settings.name == CasksScreen.route) {
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => FilteredCasksBloc(
            bloc: BlocProvider.of<CasksBloc>(context),
          ),
          child: CasksScreen(),
        ),
        settings: settings,
      );
    } else if (settings.name!.startsWith(FormulaScreen.route)) {
      final uri = Uri.parse(settings.name!);
      if (uri.pathSegments.length == 2) {
        final name = uri.pathSegments.last;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => FormulaBloc(
              repository: RepositoryProvider.of<ApiRepository>(context),
            )..add(FormulaLoadEvent(name: name)),
            child: FormulaScreen(
              name: name,
            ),
          ),
          settings: settings,
        );
      }
    } else if (settings.name!.startsWith(CaskScreen.route)) {
      final uri = Uri.parse(settings.name!);
      if (uri.pathSegments.length == 2) {
        final token = uri.pathSegments.last;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CaskBloc(
              repository: RepositoryProvider.of<ApiRepository>(context),
            )..add(CaskLoadEvent(token: token)),
            child: CaskScreen(
              token: token,
            ),
          ),
          settings: settings,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiRepository(
        api: ApiService(),
        cache: kIsWeb ? CacheServiceWeb() : CacheService(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsTestCubit(),
          ),
          BlocProvider(
            create: (context) => FormulaeBloc(
              repository: RepositoryProvider.of<ApiRepository>(context),
            )..add(FormulaeLoadEvent()),
          ),
          BlocProvider(
            create: (context) => CasksBloc(
              repository: RepositoryProvider.of<ApiRepository>(context),
            )..add(CasksLoadEvent()),
          ),
          BlocProvider(
            create: (context) => CompletionsBloc()..add(CompletionsLoadEvent()),
          ),
        ],
        child: KeyboardDismisser(
          child: MaterialApp(
            title: 'Brewery',
            theme: BreweryTheme.data,
            onGenerateRoute: _routes,
            navigatorKey: _nav,
          ),
        ),
      ),
    );
  }
}
