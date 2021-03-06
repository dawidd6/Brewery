import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/filtered_casks/filtered_casks_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/screens/cask_screen.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/model_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasksScreen extends StatefulWidget {
  CasksScreen({Key? key});

  @override
  _CasksScreenState createState() => _CasksScreenState();
}

class _CasksScreenState extends State<CasksScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBloc = BlocProvider.of<FilteredCasksBloc>(context);

    return BlocBuilder<CasksBloc, CasksState>(
      bloc: filteredBloc.bloc,
      builder: (context, state) => Scaffold(
        appBar: state is CasksLoadedState
            ? AppBar(
                title: BlocBuilder<FilteredCasksBloc, FilteredCasksState>(
                  builder: (context, state) => RegexpFilter(
                    controller: _controller..text = state.filter,
                    title: 'Search casks',
                    onChanged: (filter) => filteredBloc.add(
                      FilteredCasksFilterEvent(filter: filter),
                    ),
                  ),
                ),
              )
            : null,
        body: CenterSwitcher(
          builder: (context) {
            if (state is CasksLoadedState) {
              return BlocBuilder<FilteredCasksBloc, FilteredCasksState>(
                builder: (context, state) => ModelList<Cask>(
                  filter: RegExp(_controller.text),
                  itemList: state.casks,
                  onTileClick: (cask) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CaskScreen(
                        cask: cask,
                      ),
                    ),
                  ),
                  tileTitleBuilder: (cask) => cask.token,
                  tileSubtitleBuilder: (cask) => cask.description,
                  tileTrailingBuilder: (cask) => cask.version,
                ),
              );
            } else if (state is CasksErrorState) {
              return FailureText(
                message: state.error.toString(),
                onRefresh: () => filteredBloc.bloc.add(CasksLoadEvent()),
              );
            } else if (state is CasksLoadingState) {
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
