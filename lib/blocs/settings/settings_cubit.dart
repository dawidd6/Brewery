part of 'settings_bloc.dart';

abstract class SettingsBaseCubit extends Cubit<bool> {
  SettingsBaseCubit(bool value) : super(value);

  String get key;

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    final value = preferences.getBool(key);
    return emit(value ?? state);
  }

  Future<void> set(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
    return emit(value);
  }
}

class SettingsTestCubit extends SettingsBaseCubit {
  SettingsTestCubit() : super(false);

  @override
  String get key => 'test';
}
