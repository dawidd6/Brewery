import 'package:brewery/models/formula.dart';
import 'package:brewery/pages/formula_page.dart';
import 'package:brewery/viewmodels/formulae_viewmodel.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
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
      valueListenable: viewModel,
      builder: (context, _, child) {
        if (viewModel.formulae != null)
          return Column(
            children: [
              RegexpFilter(
                callback: (filter) => viewModel.filter(filter),
                controller: viewModel.filterController,
              ),
              RefreshableList<Formula>(
                itemList: viewModel.formulae,
                onRefresh: () => viewModel.fetch(cache: false),
                tileTitleBuilder: (formula) => formula.name,
                tileSubtitleBuilder: (formula) => formula.description,
                tileTrailingBuilder: (formula) => formula.version,
                pageBuilder: (formula) => FormulaPage(formula: formula),
              ),
            ],
          );
        else if (viewModel.error != null)
          return FailureText(
            message: viewModel.error.toString(),
          );
        else
          return LoadingIcon();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
