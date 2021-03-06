part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {}

class SettingsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsLoadedState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsErrorState extends SettingsState {
  final Object error;

  SettingsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
