import 'dart:async';

import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/formula.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'filtered_formulae_event.dart';
part 'filtered_formulae_state.dart';

class FilteredFormulaeBloc
    extends Bloc<FilteredFormulaeEvent, FilteredFormulaeState> {
  final FormulaeBloc bloc;
  late StreamSubscription _subscription;

  FilteredFormulaeBloc({required this.bloc})
      : super(FilteredFormulaeState(
          filter: RegExp(''),
          formulae: [],
        )) {
    _subscription = bloc.stream.listen((state) {
      if (state is FormulaeLoadedState) {
        add(FilteredFormulaeUpdateEvent(formulae: state.formulae));
      }
    });
  }

  List<Formula> _filterFormulae(RegExp filter, List<Formula> formulae) {
    return formulae.where((formula) => filter.hasMatch(formula.name)).toList();
  }

  @override
  Stream<FilteredFormulaeState> mapEventToState(
      FilteredFormulaeEvent event) async* {
    if (event is FilteredFormulaeFilterEvent) {
      final filter = RegExp(event.filter, caseSensitive: false);
      final blocState = bloc.state;

      if (blocState is FormulaeLoadedState) {
        yield FilteredFormulaeState(
          filter: filter,
          formulae: _filterFormulae(
            filter,
            blocState.formulae,
          ),
        );
      } else {
        yield FilteredFormulaeState(
          filter: filter,
          formulae: state.formulae,
        );
      }
    } else if (event is FilteredFormulaeUpdateEvent) {
      yield FilteredFormulaeState(
        filter: state.filter,
        formulae: _filterFormulae(state.filter, event.formulae),
      );
    }
  }

  @override
  Stream<Transition<FilteredFormulaeEvent, FilteredFormulaeState>>
      transformEvents(Stream<FilteredFormulaeEvent> events, transitionFn) {
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
