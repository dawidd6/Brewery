import 'package:brewery/events/settings_events.dart';
import 'package:brewery/states/settings_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsLoadingState());
  SharedPreferences _preferences;

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsLoadEvent) {
      try {
        yield SettingsLoadingState();
        _preferences = await SharedPreferences.getInstance();
        yield SettingsReadyState(
          testValue: _preferences.getBool("test") ?? false,
        );
      } catch (e) {
        yield SettingsErrorState(e);
      }
    } else if (event is SettingsSetTestEvent) {
      try {
        await _preferences.setBool("test", event.value);
        yield SettingsReadyState(
          testValue: event.value,
        );
      } catch (e) {
        yield SettingsErrorState(e);
      }
    }
  }
}
