import 'package:flutter/cupertino.dart';

abstract class SettingsState {}

class SettingsInitialState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsReadyState extends SettingsState {
  final bool testValue;

  SettingsReadyState({
    @required this.testValue,
  });
}

class SettingsErrorState extends SettingsState {
  final Object error;

  SettingsErrorState(this.error);
}
