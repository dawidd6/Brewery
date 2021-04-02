part of 'completions_bloc.dart';

abstract class CompletionsEvent extends Equatable {}

class CompletionsLoadEvent extends CompletionsEvent {
  @override
  List<Object?> get props => [];
}

class CompletionsAddEvent extends CompletionsEvent {
  final String input;

  CompletionsAddEvent({required this.input});

  @override
  List<Object?> get props => [input];
}
