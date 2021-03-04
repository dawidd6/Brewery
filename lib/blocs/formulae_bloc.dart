import 'package:brewery/models/formula.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FormulaeEvent extends Equatable {}

abstract class FormulaeState extends Equatable {}

class FormulaeRequestEvent extends FormulaeEvent {
  @override
  List<Object?> get props => [];
}

class FormulaeFilterEvent extends FormulaeEvent {
  final String filter;

  FormulaeFilterEvent({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class FormulaeLoadingState extends FormulaeState {
  @override
  List<Object?> get props => [];
}

class FormulaeReadyState extends FormulaeState {
  final List<Formula> allFormulae;
  final List<Formula> filteredFormulae;

  FormulaeReadyState({
    required this.filteredFormulae,
    required this.allFormulae,
  });

  @override
  List<Object?> get props => [allFormulae, filteredFormulae];
}

class FormulaeErrorState extends FormulaeState {
  final Object error;

  FormulaeErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class FormulaeBloc extends Bloc<FormulaeEvent, FormulaeState> {
  List<Formula> _formulae = [];
  final ApiRepository repository;

  FormulaeBloc({required this.repository}) : super(FormulaeLoadingState());

  @override
  Stream<FormulaeState> mapEventToState(FormulaeEvent event) async* {
    if (event is FormulaeRequestEvent) {
      try {
        yield FormulaeLoadingState();
        _formulae = await repository.getFormulae();
        yield FormulaeReadyState(
          filteredFormulae: _formulae,
          allFormulae: _formulae,
        );
      } catch (e, s) {
        yield FormulaeErrorState(e);
        addError(e, s);
      }
    } else if (event is FormulaeFilterEvent) {
      yield FormulaeReadyState(
        allFormulae: _formulae,
        filteredFormulae: _formulae
            .where(
              (formula) => formula.name.contains(
                RegExp(event.filter),
              ),
            )
            .toList(),
      );
    }
  }
}
