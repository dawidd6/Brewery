part of 'filtered_formulae_bloc.dart';

class FilteredFormulaeState extends Equatable {
  final String filter;
  final List<Formula> formulae;

  FilteredFormulaeState({
    required this.filter,
    required this.formulae,
  });

  @override
  List<Object?> get props => [filter, formulae];
}
