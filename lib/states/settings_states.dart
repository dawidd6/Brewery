abstract class SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsReadyState extends SettingsState {
  final bool testValue;

  SettingsReadyState({
    required this.testValue,
  });
}

class SettingsErrorState extends SettingsState {
  final Object error;

  SettingsErrorState(this.error);
}
