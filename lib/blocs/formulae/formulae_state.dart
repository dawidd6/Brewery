part of 'formulae_bloc.dart';

abstract class FormulaeState extends Equatable {}

class FormulaeLoadingState extends FormulaeState {
  @override
  List<Object?> get props => [];
}

class FormulaeLoadedState extends FormulaeState {
  final List<Formula> formulae;

  FormulaeLoadedState({
    required this.formulae,
  });

  @override
  List<Object?> get props => [formulae];
}

class FormulaeErrorState extends FormulaeState {
  final Object error;

  FormulaeErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
