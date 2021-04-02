import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'completions_event.dart';
part 'completions_state.dart';

class CompletionsBloc extends Bloc<CompletionsEvent, CompletionsState> {
  final _key = '_queries_completions';
  bool _enabled = true;
  int _history = 5;

  CompletionsBloc() : super(CompletionsInitialState());

  @override
  Stream<CompletionsState> mapEventToState(CompletionsEvent event) async* {
    final preferences = await SharedPreferences.getInstance();
    final completions = preferences.getStringList(_key) ?? [];

    if (event is CompletionsLoadEvent) {
      yield CompletionsLoadedState(completions: completions);
    } else if (event is CompletionsAddEvent) {
      if (event.input.isEmpty || completions.contains(event.input)) {
        yield state;
      }

      completions.insert(0, event.input);

      if (completions.length > _history) {
        completions.removeRange(_history, completions.length);
      }

      await preferences.setStringList(_key, completions);
      yield CompletionsLoadedState(completions: completions);
    } else if (event is CompletionsEnableEvent) {
      _enabled = true;
    } else if (event is CompletionsDisableEvent) {
      _enabled = false;
    } else if (event is CompletionsHistoryEvent) {
      _history = event.history;
    }
  }

  Iterable<String> completions(String input) {
    if (_enabled) {
      return (state as CompletionsLoadedState).completions.where(
            (completion) => completion != input && completion.contains(input),
          );
    }
    return [];
  }
}
