import 'package:brewery/models/cask.dart';
import 'package:brewery/pages/cask_page.dart';
import 'package:brewery/viewmodels/casks_viewmodel.dart';
import 'package:brewery/widgets/refreshable_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';

class CasksPage extends StatefulWidget {
  static final String name = "Casks";

  CasksPage({Key key}) : super(key: key);

  @override
  CasksPageState createState() => CasksPageState();
}

class CasksPageState extends State<CasksPage>
    with AutomaticKeepAliveClientMixin {
  final CasksViewModel viewModel = CasksViewModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ValueListenableBuilder(
      valueListenable: viewModel.filteredCasks,
      builder: (context, formulae, child) => Column(
        children: [
          RegexpFilter(
            callback: viewModel.filter,
            controller: viewModel.filterController,
          ),
          RefreshableList<Cask>(
            onRefresh: () => viewModel.fetch(cache: false),
            itemList: viewModel.filteredCasks.value,
            tileTitleBuilder: (cask) => cask.token,
            tileSubtitleBuilder: (cask) => cask.description,
            tileTrailingBuilder: (cask) => cask.version,
            pageBuilder: (cask) => CaskPage(cask: cask),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
