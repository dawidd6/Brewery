part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {}

class SettingsInitialState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsLoadedState extends SettingsState {
  final bool enableCompletions;

  SettingsLoadedState({
    required this.enableCompletions,
  });

  SettingsLoadedState copyWith({
    bool? enableCompletions,
  }) {
    return SettingsLoadedState(
      enableCompletions: enableCompletions ?? this.enableCompletions,
    );
  }

  @override
  List<Object?> get props => [enableCompletions];
}
