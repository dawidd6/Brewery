import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/completions/completions_bloc.dart';
import 'package:brewery/blocs/filtered_casks/filtered_casks_bloc.dart';
import 'package:brewery/blocs/filtered_formulae/filtered_formulae_bloc.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/screens/cask_screen.dart';
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

class FormulaeCasksScreen extends StatelessWidget {
  static const route = '/formulae-casks';

  FormulaeCasksScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final filteredFormulaeBloc = BlocProvider.of<FilteredFormulaeBloc>(context);
    final filteredCasksBloc = BlocProvider.of<FilteredCasksBloc>(context);
    final completionsBloc = BlocProvider.of<CompletionsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: MaterialHero(
          tag: 'search',
          child: BlocBuilder<CompletionsBloc, CompletionsState>(
            builder: (context, state) => RegexpFilter(
              title: 'Search formulae and casks',
              focus: true,
              onChanged: (filter) {
                filteredFormulaeBloc.add(
                  FilteredFormulaeFilterEvent(filter: filter),
                );
                filteredCasksBloc.add(
                  FilteredCasksFilterEvent(filter: filter),
                );
              },
              onSubmitted: (input) => completionsBloc.add(
                CompletionsAddEvent(input: input),
              ),
              optionsBuilder: (value) =>
                  completionsBloc.completions(value.text),
            ),
          ),
        ),
        actions: [
          BlocBuilder<FormulaeBloc, FormulaeState>(
            builder: (context, formulaeState) =>
                BlocBuilder<CasksBloc, CasksState>(
              builder: (context, casksState) => Visibility(
                visible: formulaeState is! FormulaeLoadingState &&
                    casksState is! CasksLoadingState,
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    filteredFormulaeBloc.bloc.add(
                      FormulaeLoadEvent(),
                    );
                    filteredCasksBloc.bloc.add(
                      CasksLoadEvent(),
                    );
                  },
                ),
              ),
            ),
          ),
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
        builder: (context, formulaeState) =>
            BlocConsumer<CasksBloc, CasksState>(
          listenWhen: (context, state) =>
              state is CasksLoadedState && state.cached,
          listener: (context, state) =>
              ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                (state as CasksLoadedState).old
                    ? 'Old cached casks data loaded'
                    : 'Cached casks data loaded',
              ),
              duration: Duration(seconds: 2),
            ),
          ),
          builder: (context, casksState) => CenterSwitcher(
            builder: (context) {
              if (formulaeState is FormulaeLoadedState &&
                  casksState is CasksLoadedState) {
                return BlocBuilder<FilteredFormulaeBloc, FilteredFormulaeState>(
                  builder: (context, filteredFormulaeState) =>
                      BlocBuilder<FilteredCasksBloc, FilteredCasksState>(
                    builder: (context, filteredCasksState) {
                      if (filteredFormulaeState.formulae.isEmpty &&
                          filteredCasksState.casks.isEmpty &&
                          filteredFormulaeState.filter.pattern.isNotEmpty) {
                        return EmptyText();
                      }
                      return ModelList<Object>(
                        filter: filteredFormulaeState.filter,
                        itemList: [
                          ...filteredFormulaeState.formulae,
                          ...filteredCasksState.casks,
                        ],
                        onTileClick: (obj) {
                          if (obj is Formula) {
                            Navigator.of(context).pushNamed(
                              FormulaScreen.routeWith(obj.name),
                            );
                          } else if (obj is Cask) {
                            Navigator.of(context).pushNamed(
                              CaskScreen.routeWith(obj.token),
                            );
                          }
                        },
                        tileTitleBuilder: (obj) {
                          if (obj is Formula) {
                            return obj.name;
                          } else if (obj is Cask) {
                            return obj.token;
                          }
                          return '';
                        },
                        tileSubtitleBuilder: (obj) {
                          if (obj is Formula) {
                            return obj.description;
                          } else if (obj is Cask) {
                            return obj.description.isEmpty
                                ? obj.name
                                : obj.description;
                          }
                          return '';
                        },
                        tileTrailingBuilder: (obj) {
                          if (obj is Formula) {
                            return obj.version;
                          } else if (obj is Cask) {
                            return obj.version;
                          }
                          return '';
                        },
                        tileLeadingBuilder: (obj) {
                          if (obj is Formula) {
                            return 'Formula';
                          } else if (obj is Cask) {
                            return 'Cask';
                          }
                          return '';
                        },
                      );
                    },
                  ),
                );
              } else if (formulaeState is FormulaeErrorState ||
                  casksState is CasksErrorState) {
                final error = formulaeState is FormulaeErrorState
                    ? formulaeState.error
                    : (casksState as CasksErrorState).error;
                return FailureText(
                  error: error,
                );
              } else if (formulaeState is FormulaeLoadingState ||
                  casksState is CasksLoadingState) {
                return LoadingIcon();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
