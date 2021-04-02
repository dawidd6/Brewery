import 'package:brewery/blocs/completions/completions_bloc.dart';
import 'package:brewery/blocs/filtered_formulae/filtered_formulae_bloc.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/screens/formula_screen.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/empty_text.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/material_hero.dart';
import 'package:brewery/widgets/model_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormulaeScreen extends StatelessWidget {
  static const route = '/formulae';

  FormulaeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final filteredBloc = BlocProvider.of<FilteredFormulaeBloc>(context);
    final completionsBloc = BlocProvider.of<CompletionsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: MaterialHero(
          tag: 'search',
          child: BlocBuilder<CompletionsBloc, CompletionsState>(
            builder: (context, state) => RegexpFilter(
              title: 'Search formulae',
              onChanged: (filter) => filteredBloc.add(
                FilteredFormulaeFilterEvent(filter: filter),
              ),
              onSubmitted: (input) => completionsBloc.add(
                CompletionsAddEvent(input: input),
              ),
              optionsBuilder: (value) =>
                  completionsBloc.completions(value.text),
            ),
          ),
        ),
        actions: [
          BlocBuilder<FormulaeBloc, FormulaeState>(builder: (context, state) {
            if (state is FormulaeLoadingState) {
              return Container();
            }
            return IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => filteredBloc.bloc.add(FormulaeLoadEvent()),
            );
          }),
        ],
      ),
      body: BlocConsumer<FormulaeBloc, FormulaeState>(
        listenWhen: (context, state) =>
            state is FormulaeLoadedState && state.cached,
        listener: (context, state) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              (state as FormulaeLoadedState).old
                  ? 'Old cached formulae data loaded'
                  : 'Cached formulae data loaded',
            ),
            duration: Duration(seconds: 2),
          ),
        ),
        builder: (context, state) => CenterSwitcher(
          builder: (context) {
            if (state is FormulaeLoadedState) {
              return BlocBuilder<FilteredFormulaeBloc, FilteredFormulaeState>(
                builder: (context, state) {
                  if (state.formulae.isEmpty &&
                      state.filter.pattern.isNotEmpty) {
                    return EmptyText();
                  }
                  return ModelList<Formula>(
                    filter: state.filter,
                    itemList: state.formulae,
                    onTileClick: (formula) => Navigator.of(context).pushNamed(
                      FormulaScreen.routeWith(formula.name),
                    ),
                    tileTitleBuilder: (formula) => formula.name,
                    tileSubtitleBuilder: (formula) => formula.description,
                    tileTrailingBuilder: (formula) => formula.version,
                  );
                },
              );
            } else if (state is FormulaeErrorState) {
              return FailureText(
                error: state.error,
              );
            } else if (state is FormulaeLoadingState) {
              return LoadingIcon();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
