import 'package:brewery/models/cask.dart';

abstract class CasksState {}

class CasksLoadingState extends CasksState {}

class CasksReadyState extends CasksState {
  final List<Cask> allCasks;
  final List<Cask> filteredCasks;

  CasksReadyState({this.filteredCasks, this.allCasks});
}

class CasksErrorState extends CasksState {
  final Object error;

  CasksErrorState(this.error);
}
