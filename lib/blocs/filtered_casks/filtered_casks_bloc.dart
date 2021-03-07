import 'dart:async';

import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filtered_casks_event.dart';
part 'filtered_casks_state.dart';

class FilteredCasksBloc extends Bloc<FilteredCasksEvent, FilteredCasksState> {
  final CasksBloc bloc;
  late StreamSubscription subscription;

  FilteredCasksBloc({required this.bloc})
      : super(
          bloc.state is CasksLoadedState
              ? FilteredCasksState(
                  filter: '',
                  casks: (bloc.state as CasksLoadedState).casks,
                )
              : FilteredCasksState(filter: '', casks: []),
        ) {
    subscription = bloc.listen((state) {
      if (state is CasksLoadedState) {
        add(FilteredCasksUpdateEvent(casks: state.casks));
      }
    });
  }

  @override
  Stream<FilteredCasksState> mapEventToState(FilteredCasksEvent event) async* {
    if (event is FilteredCasksFilterEvent) {
      final casks = (bloc.state as CasksLoadedState)
          .casks
          .where((cask) => cask.token.contains(
                RegExp(event.filter),
              ))
          .toList();
      yield FilteredCasksState(filter: event.filter, casks: casks);
    } else if (event is FilteredCasksUpdateEvent) {
      yield FilteredCasksState(filter: state.filter, casks: event.casks);
    }
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
