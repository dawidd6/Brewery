part of 'filtered_casks_bloc.dart';

class FilteredCasksState extends Equatable {
  final String filter;
  final List<Cask> casks;

  FilteredCasksState({
    required this.filter,
    required this.casks,
  });

  @override
  List<Object?> get props => [filter, casks];
}
