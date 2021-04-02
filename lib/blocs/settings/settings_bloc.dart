import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitialState());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    final preferences = await SharedPreferences.getInstance();

    if (event is SettingsLoadEvent) {
      yield SettingsLoadedState(
        enableCompletions:
            preferences.getBool(SettingsEnableCompletionsEvent.key) ?? true,
        completionsHistory:
            preferences.getInt(SettingsCompletionsHistoryEvent.key) ?? 5,
      );
    } else if (event is SettingsEnableCompletionsEvent) {
      await preferences.setBool(
        SettingsEnableCompletionsEvent.key,
        event.enabled,
      );
      yield (state as SettingsLoadedState).copyWith(
        enableCompletions: event.enabled,
      );
    } else if (event is SettingsCompletionsHistoryEvent) {
      await preferences.setInt(
        SettingsCompletionsHistoryEvent.key,
        event.history,
      );
      yield (state as SettingsLoadedState).copyWith(
        completionsHistory: event.history,
      );
    }
  }
}
