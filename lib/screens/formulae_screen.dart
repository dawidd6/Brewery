import 'package:brewery/blocs/filtered_formulae/filtered_formulae_bloc.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/screens/formula_screen.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/material_hero.dart';
import 'package:brewery/widgets/model_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormulaeScreen extends StatefulWidget {
  FormulaeScreen({Key? key});

  @override
  _FormulaeScreenState createState() => _FormulaeScreenState();
}

class _FormulaeScreenState extends State<FormulaeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FilteredFormulaeBloc>(context).add(
      FilteredFormulaeFilterEvent(filter: ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredBloc = BlocProvider.of<FilteredFormulaeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: MaterialHero(
          tag: 'search',
          child: RegexpFilter(
            title: 'Search formulae',
            onChanged: (filter) => filteredBloc.add(
              FilteredFormulaeFilterEvent(filter: filter),
            ),
          ),
        ),
      ),
      body: BlocBuilder<FormulaeBloc, FormulaeState>(
        builder: (context, state) => CenterSwitcher(
          builder: (context) {
            if (state is FormulaeLoadedState) {
              return BlocBuilder<FilteredFormulaeBloc, FilteredFormulaeState>(
                builder: (context, state) => ModelList<Formula>(
                  filter: RegExp(state.filter, caseSensitive: false),
                  itemList: state.formulae,
                  onTileClick: (formula) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormulaScreen(
                        formula: formula,
                      ),
                    ),
                  ),
                  tileTitleBuilder: (formula) => formula.name,
                  tileSubtitleBuilder: (formula) => formula.description,
                  tileTrailingBuilder: (formula) => formula.version,
                ),
              );
            } else if (state is FormulaeErrorState) {
              return FailureText(
                message: state.error.toString(),
                onRefresh: () => filteredBloc.bloc.add(FormulaeLoadEvent()),
              );
            } else if (state is FormulaeLoadingState) {
              return LoadingIcon();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
