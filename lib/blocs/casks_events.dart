abstract class CasksEvent {}

class CasksRequestEvent extends CasksEvent {}

class CasksFilterEvent extends CasksEvent {
  final String filter;

  CasksFilterEvent({this.filter});
}
