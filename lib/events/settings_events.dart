abstract class SettingsEvent {}

class SettingsLoadEvent extends SettingsEvent {}

class SettingsSetTestEvent extends SettingsEvent {
  final bool value;

  SettingsSetTestEvent(this.value);
}
