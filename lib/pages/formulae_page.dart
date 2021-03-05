import 'package:brewery/blocs/formulae_bloc.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/pages/formula_page.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/refreshable_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormulaePage extends StatefulWidget {
  static const name = 'Formulae';

  FormulaePage({Key? key}) : super(key: key);

  @override
  _FormulaePageState createState() => _FormulaePageState();
}

class _FormulaePageState extends State<FormulaePage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FormulaeBloc>(context).add(FormulaeRequestEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<FormulaeBloc, FormulaeState>(
      builder: (context, state) => CenterSwitcher(
        builder: (context) {
          if (state is FormulaeReadyState) {
            return Column(
              children: [
                RegexpFilter(
                  controller: _controller,
                  onChanged: (filter) => BlocProvider.of<FormulaeBloc>(context)
                      .add(FormulaeFilterEvent(filter: filter)),
                  filteredCount: state.filteredFormulae.length,
                  totalCount: state.allFormulae.length,
                ),
                RefreshableList<Formula>(
                  itemList: state.filteredFormulae,
                  onRefresh: () async {
                    _controller.clear();
                    BlocProvider.of<FormulaeBloc>(context)
                        .add(FormulaeRequestEvent());
                    return null;
                  },
                  onTileClick: (formula) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormulaPage(
                        formula: formula,
                        formulae: state.allFormulae,
                      ),
                    ),
                  ),
                  tileTitleBuilder: (formula) => formula.name,
                  tileSubtitleBuilder: (formula) => formula.description,
                  tileTrailingBuilder: (formula) => formula.version,
                ),
              ],
            );
          } else if (state is FormulaeErrorState) {
            return FailureText(
              message: state.error.toString(),
              onRefresh: () => BlocProvider.of<FormulaeBloc>(context)
                  .add(FormulaeRequestEvent()),
            );
          } else if (state is FormulaeLoadingState) {
            return LoadingIcon();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
