part of 'filtered_formulae_bloc.dart';

abstract class FilteredFormulaeEvent extends Equatable {}

class FilteredFormulaeFilterEvent extends FilteredFormulaeEvent {
  final String filter;

  FilteredFormulaeFilterEvent({
    required this.filter,
  });

  @override
  List<Object?> get props => [filter];
}

class FilteredFormulaeUpdateEvent extends FilteredFormulaeEvent {
  final List<Formula> formulae;

  FilteredFormulaeUpdateEvent({
    required this.formulae,
  });

  @override
  List<Object?> get props => [formulae];
}
