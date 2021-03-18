import 'dart:async';

import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'filtered_casks_event.dart';
part 'filtered_casks_state.dart';

class FilteredCasksBloc extends Bloc<FilteredCasksEvent, FilteredCasksState> {
  final CasksBloc bloc;
  late StreamSubscription _subscription;

  FilteredCasksBloc({required this.bloc})
      : super(FilteredCasksState(
          filter: RegExp(''),
          casks: bloc.state is CasksLoadedState
              ? (bloc.state as CasksLoadedState).casks
              : [],
        )) {
    _subscription = bloc.stream.listen((state) {
      if (state is CasksLoadedState) {
        add(FilteredCasksUpdateEvent(casks: state.casks));
      }
    });
  }

  List<Cask> _filterCasks(RegExp filter, List<Cask> casks) {
    return casks.where((cask) => filter.hasMatch(cask.token)).toList();
  }

  @override
  Stream<FilteredCasksState> mapEventToState(FilteredCasksEvent event) async* {
    if (event is FilteredCasksFilterEvent) {
      final filter = RegExp(event.filter, caseSensitive: false);

      if (bloc.state is CasksLoadedState) {
        yield FilteredCasksState(
          filter: filter,
          casks: _filterCasks(
            filter,
            (bloc.state as CasksLoadedState).casks,
          ),
        );
      } else {
        yield FilteredCasksState(
          filter: filter,
          casks: state.casks,
        );
      }
    } else if (event is FilteredCasksUpdateEvent) {
      yield FilteredCasksState(
        filter: state.filter,
        casks: _filterCasks(state.filter, event.casks),
      );
    }
  }

  @override
  Stream<Transition<FilteredCasksEvent, FilteredCasksState>> transformEvents(
      Stream<FilteredCasksEvent> events, transitionFn) {
    return events
        .debounceTime(Duration(milliseconds: 500))
        .switchMap(transitionFn);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
