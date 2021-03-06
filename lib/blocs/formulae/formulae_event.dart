part of 'formulae_bloc.dart';

abstract class FormulaeEvent extends Equatable {}

class FormulaeLoadEvent extends FormulaeEvent {
  @override
  List<Object?> get props => [];
}

class FormulaeFilterEvent extends FormulaeEvent {
  final String filter;

  FormulaeFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
