part of 'casks_bloc.dart';

abstract class CasksState extends Equatable {}

class CasksLoadingState extends CasksState {
  @override
  List<Object?> get props => [];
}

class CasksLoadedState extends CasksState {
  final List<Cask> casks;
  final bool cached;

  CasksLoadedState({
    required this.casks,
    required this.cached,
  });

  @override
  List<Object?> get props => [casks];
}

class CasksErrorState extends CasksState {
  final Object error;

  CasksErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
