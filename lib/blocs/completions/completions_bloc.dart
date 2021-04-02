import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'completions_event.dart';
part 'completions_state.dart';

class CompletionsBloc extends Bloc<CompletionsEvent, CompletionsState> {
  final _key = '_queries_completions';

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

      if (completions.length > 5) {
        completions.removeRange(5, completions.length);
      }

      await preferences.setStringList(_key, completions);
      yield CompletionsLoadedState(completions: completions);
    }
  }

  Iterable<String> completions(String input) =>
      (state as CompletionsLoadedState).completions.where(
            (completion) => completion != input && completion.contains(input),
          );
}
