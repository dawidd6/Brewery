part of 'formula_bloc.dart';

abstract class FormulaEvent extends Equatable {}

class FormulaLoadEvent extends FormulaEvent {
  final String name;

  FormulaLoadEvent({required this.name});

  @override
  List<Object?> get props => [name];
}
