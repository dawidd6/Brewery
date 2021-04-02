import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QueriesCubit extends Cubit<List<String>> {
  final _key = '_queries_completions';

  QueriesCubit() : super([]);

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    final queries = preferences.getStringList(_key) ?? [];
    emit(queries);
  }

  Future<void> add(String query) async {
    final preferences = await SharedPreferences.getInstance();
    final queries = preferences.getStringList(_key) ?? [];

    if (query.isEmpty || queries.contains(query)) {
      return;
    }

    queries.insert(0, query);
    if (queries.length > 5) {
      queries.removeRange(5, queries.length);
    }

    await preferences.setStringList(_key, queries);
    emit(queries);
  }

  Iterable<String> queries(String input) => state.where(
        (query) => query != input && query.contains(input),
      );
}
