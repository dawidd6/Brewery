part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {}

class SettingsInitialState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsLoadedState extends SettingsState {
  final bool enableCompletions;
  final int completionsHistory;

  SettingsLoadedState({
    required this.enableCompletions,
    required this.completionsHistory,
  });

  SettingsLoadedState copyWith({
    bool? enableCompletions,
    int? completionsHistory,
  }) {
    return SettingsLoadedState(
      enableCompletions: enableCompletions ?? this.enableCompletions,
      completionsHistory: completionsHistory ?? this.completionsHistory,
    );
  }

  @override
  List<Object?> get props => [
        enableCompletions,
        completionsHistory,
      ];
}
