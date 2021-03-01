import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends ValueNotifier {
  SharedPreferences _preferences;
  ValueNotifier<bool> _test = ValueNotifier(false);

  SettingsViewModel() : super(null) {
    fetch();
  }

  SharedPreferences get preferences => _preferences;

  void fetch() async {
    _preferences = await SharedPreferences.getInstance();
    _test.addListener(() {
      _preferences.setBool("test", _test.value);
    });
    notifyListeners();
  }

  setTest(bool value) {
    _test.value = value;
    notifyListeners();
  }

  bool getTest() => _preferences.getBool("test");
}
