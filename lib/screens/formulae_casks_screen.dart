import 'package:brewery/blocs/casks/casks_bloc.dart';
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

class FormulaeCasksScreen extends StatefulWidget {
  static const route = '/formulae-casks';

  FormulaeCasksScreen({Key? key});

  @override
  _FormulaeCasksScreenState createState() => _FormulaeCasksScreenState();
}

class _FormulaeCasksScreenState extends State<FormulaeCasksScreen> {
  late final FilteredFormulaeBloc filteredFormulaeBloc;
  late final FilteredCasksBloc filteredCasksBloc;

  @override
  void initState() {
    super.initState();
    filteredFormulaeBloc = BlocProvider.of<FilteredFormulaeBloc>(context);
    filteredCasksBloc = BlocProvider.of<FilteredCasksBloc>(context);
  }

  @override
  void dispose() {
    filteredFormulaeBloc.add(FilteredFormulaeFilterEvent(filter: ''));
    filteredCasksBloc.add(FilteredCasksFilterEvent(filter: ''));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MaterialHero(
          tag: 'search',
          child: RegexpFilter(
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
          ),
        ),
        actions: [
          BlocBuilder<FormulaeBloc, FormulaeState>(
            builder: (context, formulaeState) =>
                BlocBuilder<CasksBloc, CasksState>(
              builder: (context, casksState) {
                if (formulaeState is FormulaeLoadingState ||
                    casksState is CasksLoadingState) {
                  return Container();
                }
                return IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    filteredFormulaeBloc.bloc.add(
                      FormulaeLoadEvent(),
                    );
                    filteredCasksBloc.bloc.add(
                      CasksLoadEvent(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<FormulaeBloc, FormulaeState>(
        builder: (context, formulaeState) => BlocBuilder<CasksBloc, CasksState>(
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
                  message: error.toString(),
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
