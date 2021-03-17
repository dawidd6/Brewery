import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/filtered_casks/filtered_casks_bloc.dart';
import 'package:brewery/blocs/filtered_formulae/filtered_formulae_bloc.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/styles/brewery_icons.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/material_hero.dart';
import 'package:brewery/widgets/model_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vrouter/vrouter.dart';

class FormulaeCasksScreen extends StatefulWidget {
  FormulaeCasksScreen({Key? key});

  @override
  _FormulaeCasksScreenState createState() => _FormulaeCasksScreenState();
}

class _FormulaeCasksScreenState extends State<FormulaeCasksScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FilteredFormulaeBloc>(context).add(
      FilteredFormulaeFilterEvent(filter: ''),
    );
    BlocProvider.of<FilteredCasksBloc>(context).add(
      FilteredCasksFilterEvent(filter: ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredFormulaeBloc = BlocProvider.of<FilteredFormulaeBloc>(context);
    final filteredCasksBloc = BlocProvider.of<FilteredCasksBloc>(context);

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
                    builder: (context, filteredCasksState) => ModelList<Object>(
                      filter: filteredFormulaeState.filter,
                      itemList: [
                        ...filteredFormulaeState.formulae,
                        ...filteredCasksState.casks,
                      ],
                      onTileClick: (obj) {
                        if (obj is Formula) {
                          VRouterData.of(context).push('/formula/${obj.name}');
                        } else if (obj is Cask) {
                          VRouterData.of(context).push('/cask/${obj.token}');
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
                          return Icon(BreweryIcons.recipe_book);
                        } else if (obj is Cask) {
                          return Icon(BreweryIcons.wine_cask);
                        }
                      },
                    ),
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
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
