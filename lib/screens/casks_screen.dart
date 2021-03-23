import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/filtered_casks/filtered_casks_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/screens/cask_screen.dart';
import 'package:brewery/widgets/center_switcher.dart';
import 'package:brewery/widgets/empty_text.dart';
import 'package:brewery/widgets/failure_text.dart';
import 'package:brewery/widgets/loading_icon.dart';
import 'package:brewery/widgets/material_hero.dart';
import 'package:brewery/widgets/model_list.dart';
import 'package:brewery/widgets/regexp_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasksScreen extends StatefulWidget {
  static const route = '/casks';

  CasksScreen({Key? key});

  @override
  _CasksScreenState createState() => _CasksScreenState();
}

class _CasksScreenState extends State<CasksScreen> {
  late final FilteredCasksBloc filteredBloc;

  @override
  void initState() {
    super.initState();
    filteredBloc = BlocProvider.of<FilteredCasksBloc>(context);
  }

  @override
  void dispose() {
    filteredBloc.add(FilteredCasksFilterEvent(filter: ''));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MaterialHero(
          tag: 'search',
          child: RegexpFilter(
            title: 'Search casks',
            onChanged: (filter) => filteredBloc.add(
              FilteredCasksFilterEvent(filter: filter),
            ),
          ),
        ),
        actions: [
          BlocBuilder<CasksBloc, CasksState>(builder: (context, state) {
            if (state is CasksLoadingState) {
              return Container();
            }
            return IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => filteredBloc.bloc.add(CasksLoadEvent()),
            );
          }),
        ],
      ),
      body: BlocConsumer<CasksBloc, CasksState>(
        listenWhen: (context, state) =>
            state is CasksLoadedState && state.cached,
        listener: (context, state) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cached casks data loaded'),
            duration: Duration(seconds: 2),
          ),
        ),
        builder: (context, state) => CenterSwitcher(
          builder: (context) {
            if (state is CasksLoadedState) {
              return BlocBuilder<FilteredCasksBloc, FilteredCasksState>(
                builder: (context, state) {
                  if (state.casks.isEmpty && state.filter.pattern.isNotEmpty) {
                    return EmptyText();
                  }
                  return ModelList<Cask>(
                    filter: state.filter,
                    itemList: state.casks,
                    onTileClick: (cask) => Navigator.of(context).pushNamed(
                      CaskScreen.routeWith(cask.token),
                    ),
                    tileTitleBuilder: (cask) => cask.token,
                    tileSubtitleBuilder: (cask) =>
                        cask.description.isEmpty ? cask.name : cask.description,
                    tileTrailingBuilder: (cask) => cask.version,
                    tileLeadingBuilder: (cask) => '',
                  );
                },
              );
            } else if (state is CasksErrorState) {
              return FailureText(
                message: state.error.toString(),
              );
            } else if (state is CasksLoadingState) {
              return LoadingIcon();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
