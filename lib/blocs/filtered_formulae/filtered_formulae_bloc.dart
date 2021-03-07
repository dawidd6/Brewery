import 'dart:async';

import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/formula.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      final formulae = (bloc.state as FormulaeLoadedState)
          .formulae
          .where((formula) => formula.name.contains(
                RegExp(event.filter),
              ))
          .toList();
      yield FilteredFormulaeState(filter: event.filter, formulae: formulae);
    } else if (event is FilteredFormulaeUpdateEvent) {
      yield FilteredFormulaeState(filter: state.filter, formulae: event.formulae);
    }
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
