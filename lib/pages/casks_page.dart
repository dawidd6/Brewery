import 'package:brewery/blocs/casks_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/screens/cask_screen.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/refreshable_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasksPage extends StatefulWidget {
  static const name = 'Casks';

  CasksPage({Key? key}) : super(key: key);

  @override
  _CasksPageState createState() => _CasksPageState();
}

class _CasksPageState extends State<CasksPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CasksBloc>(context);
    super.build(context);
    return BlocBuilder<CasksBloc, CasksState>(
      builder: (context, state) => CenterSwitcher(
        builder: (context) {
          if (state is CasksReadyState) {
            return Column(
              children: [
                RegexpFilter(
                  controller: _controller,
                  onChanged: (filter) =>
                      bloc.add(CasksFilterEvent(filter: filter)),
                  filteredCount: state.filteredCasks.length,
                  totalCount: state.allCasks.length,
                ),
                RefreshableList<Cask>(
                  itemList: state.filteredCasks,
                  onRefresh: () async {
                    _controller.clear();
                    bloc.add(CasksRequestEvent());
                    return null;
                  },
                  onTileClick: (cask) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CaskScreen(
                        cask: cask,
                        casks: state.allCasks,
                      ),
                    ),
                  ),
                  tileTitleBuilder: (cask) => cask.token,
                  tileSubtitleBuilder: (cask) => cask.description,
                  tileTrailingBuilder: (cask) => cask.version,
                ),
              ],
            );
          } else if (state is CasksErrorState) {
            return FailureText(
              message: state.error.toString(),
              onRefresh: () => bloc.add(CasksRequestEvent()),
            );
          } else if (state is CasksLoadingState) {
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
