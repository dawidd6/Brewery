part of 'formulae_bloc.dart';

abstract class FormulaeState extends Equatable {}

class FormulaeLoadingState extends FormulaeState {
  @override
  List<Object?> get props => [];
}

class FormulaeLoadedState extends FormulaeState {
  final List<Formula> formulae;
  final bool cached;

  FormulaeLoadedState({
    required this.formulae,
    required this.cached,
  });

  @override
  List<Object?> get props => [formulae, cached];
}

class FormulaeErrorState extends FormulaeState {
  final Object error;

  FormulaeErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
