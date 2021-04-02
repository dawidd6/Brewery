part of 'completions_bloc.dart';

abstract class CompletionsEvent extends Equatable {}

class CompletionsLoadEvent extends CompletionsEvent {
  @override
  List<Object?> get props => [];
}

class CompletionsEnableEvent extends CompletionsEvent {
  @override
  List<Object?> get props => [];
}

class CompletionsDisableEvent extends CompletionsEvent {
  @override
  List<Object?> get props => [];
}

class CompletionsHistoryEvent extends CompletionsEvent {
  final int history;

  CompletionsHistoryEvent({required this.history});

  @override
  List<Object?> get props => [history];
}

class CompletionsAddEvent extends CompletionsEvent {
  final String input;

  CompletionsAddEvent({required this.input});

  @override
  List<Object?> get props => [input];
}
