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
  late StreamSubscription subscription;

  FilteredFormulaeBloc({required this.bloc})
      : super(
          bloc.state is FormulaeLoadedState
              ? FilteredFormulaeState(
                  filter: '',
                  formulae: (bloc.state as FormulaeLoadedState).formulae,
                )
              : FilteredFormulaeState(filter: '', formulae: []),
        ) {
    subscription = bloc.listen((state) {
      if (state is FormulaeLoadedState) {
        add(FilteredFormulaeUpdateEvent(formulae: state.formulae));
      }
    });
  }

  @override
  Stream<FilteredFormulaeState> mapEventToState(
      FilteredFormulaeEvent event) async* {
    if (event is FilteredFormulaeFilterEvent) {
      if (bloc.state is FormulaeLoadedState) {
        final formulae = _filter(
          event.filter,
          (bloc.state as FormulaeLoadedState).formulae,
        );
        yield FilteredFormulaeState(filter: event.filter, formulae: formulae);
      } else {
        yield FilteredFormulaeState(
          filter: event.filter,
          formulae: state.formulae,
        );
      }
    } else if (event is FilteredFormulaeUpdateEvent) {
      final formulae = _filter(state.filter, event.formulae);
      yield FilteredFormulaeState(filter: state.filter, formulae: formulae);
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
    subscription.cancel();
    return super.close();
  }

  List<Formula> _filter(String filter, List<Formula> formulae) {
    return formulae
        .where((formula) => formula.name.contains(
              RegExp(filter),
            ))
        .toList();
  }
}
