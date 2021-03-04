import 'package:brewery/events/formulae_events.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:brewery/states/formulae_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
