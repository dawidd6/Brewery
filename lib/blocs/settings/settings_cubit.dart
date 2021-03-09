import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsBaseCubit extends Cubit<bool> {
  SettingsBaseCubit(bool value) : super(value) {
    _load();
  }

  String get key;

  Future<void> _load() async {
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
