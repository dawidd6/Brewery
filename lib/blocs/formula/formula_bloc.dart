import 'package:brewery/models/formula.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'formula_event.dart';
part 'formula_state.dart';

class FormulaBloc extends Bloc<FormulaEvent, FormulaState> {
  final ApiRepository repository;

  FormulaBloc({required this.repository}) : super(FormulaIdleState());

  @override
  Stream<FormulaState> mapEventToState(FormulaEvent event) async* {
    if (event is FormulaLoadEvent) {
      try {
        yield FormulaLoadingState();
        yield FormulaLoadedState(
          formula: await repository.getFormula(event.name),
        );
      } catch (e, s) {
        yield FormulaErrorState(e);
        addError(e, s);
      }
    }
  }
}
