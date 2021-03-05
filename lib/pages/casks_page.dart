import 'package:brewery/blocs/casks_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/pages/cask_page.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_beer.dart';
import 'package:brewery/widgets/refreshable_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasksPage extends StatefulWidget {
  static final name = 'Casks';

  CasksPage({Key? key}) : super(key: key);

  @override
  _CasksPageState createState() => _CasksPageState();
}

class _CasksPageState extends State<CasksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CasksBloc>(context).add(CasksRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CasksBloc, CasksState>(
      builder: (context, state) => CenterSwitcher(
        builder: (context) {
          if (state is CasksReadyState) {
            return Column(
              children: [
                RegexpFilter(
                  onChanged: (filter) => BlocProvider.of<CasksBloc>(context)
                      .add(CasksFilterEvent(filter: filter)),
                  filteredCount: state.filteredCasks.length,
                  totalCount: state.allCasks.length,
                ),
                RefreshableList<Cask>(
                  itemList: state.filteredCasks,
                  onRefresh: () async {
                    BlocProvider.of<CasksBloc>(context)
                        .add(CasksRequestEvent());
                    return null;
                  },
                  tileTitleBuilder: (cask) => cask.token,
                  tileSubtitleBuilder: (cask) => cask.description,
                  tileTrailingBuilder: (cask) => cask.version,
                  pageBuilder: (cask) => CaskPage(cask: cask),
                ),
              ],
            );
          } else if (state is CasksErrorState) {
            return FailureText(
              message: state.error.toString(),
              onRefresh: () =>
                  BlocProvider.of<CasksBloc>(context).add(CasksRequestEvent()),
            );
          } else if (state is CasksLoadingState) {
            return LoadingBeer();
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
