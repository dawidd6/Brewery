part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {}

class SettingsLoadEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

class SettingsEnableCompletionsEvent extends SettingsEvent {
  static const key = 'enable_completions';

  final bool enabled;

  SettingsEnableCompletionsEvent({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}
