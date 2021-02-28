import 'package:brewery/models/cask.dart';
import 'package:brewery/pages/cask_page.dart';
import 'package:brewery/viewmodels/casks_viewmodel.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
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
      valueListenable: viewModel,
      builder: (context, _, child) => AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: () {
          if (viewModel.filteredCasks != null)
            return Column(
              children: [
                RegexpFilter(
                  onChanged: (filter) => viewModel.filter(filter),
                  controller: viewModel.filterController,
                  filteredCount: viewModel.filteredCasks.length,
                  totalCount: viewModel.fetchedCasks.length,
                ),
                RefreshableList<Cask>(
                  itemList: viewModel.filteredCasks,
                  onRefresh: () => viewModel.fetch(cache: false),
                  tileTitleBuilder: (cask) => cask.token,
                  tileSubtitleBuilder: (cask) => cask.description,
                  tileTrailingBuilder: (cask) => cask.version,
                  pageBuilder: (cask) => CaskPage(cask: cask),
                ),
              ],
            );
          else if (viewModel.error != null)
            return FailureText(
              message: "Data fetching failed",
              onRefresh: () => viewModel.fetch(cache: false),
            );
          else
            return LoadingIcon();
        }(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
