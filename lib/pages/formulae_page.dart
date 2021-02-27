import 'package:brewery/models/formula.dart';
import 'package:brewery/pages/formula_page.dart';
import 'package:brewery/viewmodels/formulae_viewmodel.dart';
import 'package:brewery/widgets/refreshable_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';

class FormulaePage extends StatefulWidget {
  static final String name = "Formulae";

  FormulaePage({Key key}) : super(key: key);

  @override
  FormulaePageState createState() => FormulaePageState();
}

class FormulaePageState extends State<FormulaePage>
    with AutomaticKeepAliveClientMixin {
  FormulaeViewModel viewModel = FormulaeViewModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ValueListenableBuilder(
      valueListenable: viewModel.filteredFormulae,
      builder: (context, formulae, child) => Column(
        children: [
          RegexpFilter(
            callback: viewModel.filter,
            controller: viewModel.filterController,
          ),
          RefreshableList<Formula>(
            onRefresh: viewModel.fetch,
            itemList: viewModel.filteredFormulae.value,
            tileTitleBuilder: (formula) => formula.name,
            tileSubtitleBuilder: (formula) => formula.description,
            tileTrailingBuilder: (formula) => formula.version,
            pageBuilder: (formula) => FormulaPage(formula: formula),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
