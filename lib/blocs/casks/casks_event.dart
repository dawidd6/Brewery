part of 'casks_bloc.dart';

abstract class CasksEvent extends Equatable {}

class CasksLoadEvent extends CasksEvent {
  @override
  List<Object?> get props => [];
}

class CasksFilterEvent extends CasksEvent {
  final String filter;

  CasksFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
