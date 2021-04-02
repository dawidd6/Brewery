part of 'completions_bloc.dart';

abstract class CompletionsState extends Equatable {}

class CompletionsInitialState extends CompletionsState {
  @override
  List<Object?> get props => [];
}

class CompletionsLoadedState extends CompletionsState {
  final List<String> completions;

  CompletionsLoadedState({
    required this.completions,
  });

  @override
  List<Object?> get props => [completions];
}
