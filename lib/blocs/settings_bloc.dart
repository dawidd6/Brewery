import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsEvent extends Equatable {}

abstract class SettingsState extends Equatable {}

class SettingsLoadEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

class SettingsSetEvent extends SettingsEvent {
  final SettingsKey key;
  final bool value;

  SettingsSetEvent(this.key, this.value);

  @override
  List<Object?> get props => [key, value];
}

class SettingsInitialState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsReadyState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsErrorState extends SettingsState {
  final Object error;

  SettingsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

enum SettingsKey {
  test,
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsTestCubit test = SettingsTestCubit();

  SettingsBloc() : super(SettingsInitialState());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsLoadEvent) {
      try {
        yield SettingsLoadingState();
        await test.load();
        yield SettingsReadyState();
      } catch (e, s) {
        yield SettingsErrorState(e);
        addError(e, s);
      }
    }
  }
}

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
