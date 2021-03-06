import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_cubit.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsTestCubit test = SettingsTestCubit();

  SettingsBloc() : super(SettingsLoadingState()) {
    add(SettingsLoadEvent());
  }

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsLoadEvent) {
      try {
        yield SettingsLoadingState();
        await test.load();
        yield SettingsLoadedState();
      } catch (e, s) {
        yield SettingsErrorState(e);
        addError(e, s);
      }
    }
  }
}
