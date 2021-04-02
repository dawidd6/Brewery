import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/completions/completions_bloc.dart';
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

class CasksScreen extends StatelessWidget {
  static const route = '/casks';

  CasksScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final filteredBloc = BlocProvider.of<FilteredCasksBloc>(context);
    final completionsBloc = BlocProvider.of<CompletionsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: MaterialHero(
          tag: 'search',
          child: BlocBuilder<CompletionsBloc, CompletionsState>(
            builder: (context, state) => RegexpFilter(
              title: 'Search casks',
              onChanged: (filter) => filteredBloc.add(
                FilteredCasksFilterEvent(filter: filter),
              ),
              onSubmitted: (input) => completionsBloc.add(
                CompletionsAddEvent(input: input),
              ),
              optionsBuilder: (value) =>
                  completionsBloc.completions(value.text),
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
            content: Text(
              (state as CasksLoadedState).old
                  ? 'Old cached casks data loaded'
                  : 'Cached casks data loaded',
            ),
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
                  );
                },
              );
            } else if (state is CasksErrorState) {
              return FailureText(
                error: state.error,
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
