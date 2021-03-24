part of 'formula_bloc.dart';

abstract class FormulaState extends Equatable {}

class FormulaIdleState extends FormulaState {
  @override
  List<Object?> get props => [];
}

class FormulaLoadingState extends FormulaState {
  @override
  List<Object?> get props => [];
}

class FormulaLoadedState extends FormulaState {
  final Formula formula;

  FormulaLoadedState({
    required this.formula,
  });

  @override
  List<Object?> get props => [formula];
}

class FormulaErrorState extends FormulaState {
  final Object error;

  FormulaErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
