part of 'filtered_casks_bloc.dart';

abstract class FilteredCasksEvent extends Equatable {}

class FilteredCasksFilterEvent extends FilteredCasksEvent {
  final String filter;

  FilteredCasksFilterEvent({
    required this.filter,
  });

  @override
  List<Object?> get props => [filter];
}

class FilteredCasksUpdateEvent extends FilteredCasksEvent {
  final List<Cask> casks;

  FilteredCasksUpdateEvent({
    required this.casks,
  });

  @override
  List<Object?> get props => [casks];
}
