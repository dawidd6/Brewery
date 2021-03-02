import 'package:brewery/blocs/formulae_bloc.dart';
import 'package:brewery/events/formulae_events.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/pages/formula_page.dart';
import 'package:brewery/states/formulae_states.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/refreshable_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormulaePage extends StatefulWidget {
  static final name = "Formulae";

  FormulaePage({Key key}) : super(key: key);

  @override
  FormulaePageState createState() => FormulaePageState();
}

class FormulaePageState extends State<FormulaePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<FormulaeBloc>().add(FormulaeRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<FormulaeBloc, FormulaeState>(
      builder: (context, state) => CenterSwitcher(
        builder: (context) {
          if (state is FormulaeReadyState)
            return Column(
              children: [
                RegexpFilter(
                  onChanged: (filter) => context
                      .read<FormulaeBloc>()
                      .add(FormulaeFilterEvent(filter: filter)),
                  filteredCount: state.filteredFormulae.length,
                  totalCount: state.allFormulae.length,
                ),
                RefreshableList<Formula>(
                  itemList: state.filteredFormulae,
                  onRefresh: () async {
                    context.read<FormulaeBloc>().add(FormulaeRequestEvent());
                    return null;
                  },
                  tileTitleBuilder: (formula) => formula.name,
                  tileSubtitleBuilder: (formula) => formula.description,
                  tileTrailingBuilder: (formula) => formula.version,
                  pageBuilder: (formula) => FormulaPage(formula: formula),
                ),
              ],
            );
          else if (state is FormulaeErrorState)
            return FailureText(
              message: state.error.toString(),
              onRefresh: () =>
                  context.read<FormulaeBloc>().add(FormulaeRequestEvent()),
            );
          else if (state is FormulaeLoadingState)
            return LoadingIcon();
          else
            return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
