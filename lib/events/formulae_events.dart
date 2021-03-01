abstract class FormulaeEvent {}

class FormulaeRequestEvent extends FormulaeEvent {}

class FormulaeFilterEvent extends FormulaeEvent {
  final String filter;

  FormulaeFilterEvent({this.filter});
}
