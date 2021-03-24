part of 'cask_bloc.dart';

abstract class CaskState extends Equatable {}

class CaskIdleState extends CaskState {
  @override
  List<Object?> get props => [];
}

class CaskLoadingState extends CaskState {
  @override
  List<Object?> get props => [];
}

class CaskLoadedState extends CaskState {
  final Cask cask;

  CaskLoadedState({
    required this.cask,
  });

  @override
  List<Object?> get props => [cask];
}

class CaskErrorState extends CaskState {
  final Object error;

  CaskErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
