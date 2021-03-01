import 'package:brewery/blocs/casks_bloc.dart';
import 'package:brewery/blocs/casks_events.dart';
import 'package:brewery/blocs/casks_states.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/pages/cask_page.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/refreshable_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasksPage extends StatefulWidget {
  static final String name = "Casks";

  CasksPage({Key key}) : super(key: key);

  @override
  CasksPageState createState() => CasksPageState();
}

class CasksPageState extends State<CasksPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CasksBloc>().add(CasksRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CasksBloc, CasksState>(
      builder: (context, state) => AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: () {
          if (state is CasksReadyState)
            return Column(
              children: [
                RegexpFilter(
                  onChanged: (filter) => context
                      .read<CasksBloc>()
                      .add(CasksFilterEvent(filter: filter)),
                  controller: editingController,
                  filteredCount: state.filteredCasks.length,
                  totalCount: state.allCasks.length,
                ),
                RefreshableList<Cask>(
                  itemList: state.filteredCasks,
                  onRefresh: () {
                    editingController.clear();
                    context.read<CasksBloc>().add(CasksRequestEvent());
                    return null;
                  },
                  tileTitleBuilder: (cask) => cask.token,
                  tileSubtitleBuilder: (cask) => cask.description,
                  tileTrailingBuilder: (cask) => cask.version,
                  pageBuilder: (cask) => CaskPage(cask: cask),
                ),
              ],
            );
          else if (state is CasksErrorState)
            return FailureText(
              message: state.object.toString(),
              onRefresh: () =>
                  context.read<CasksBloc>().add(CasksRequestEvent()),
            );
          else if (state is CasksLoadingState)
            return LoadingIcon();
          else
            return Container();
        }(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
