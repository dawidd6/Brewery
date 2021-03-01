import 'package:brewery/models/formula.dart';

abstract class FormulaeState {}

class FormulaeLoadingState extends FormulaeState {}

class FormulaeReadyState extends FormulaeState {
  final List<Formula> allFormulae;
  final List<Formula> filteredFormulae;

  FormulaeReadyState({this.filteredFormulae, this.allFormulae});
}

class FormulaeErrorState extends FormulaeState {
  final Object error;

  FormulaeErrorState(this.error);
}
