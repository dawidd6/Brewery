import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/api_service.dart';
import 'package:brewery/services/cache_service.dart';

class ApiRepository {
  final ApiService api;
  final CacheService cache;

  ApiRepository({
    required this.api,
    required this.cache,
  });

  Future<List<Formula>> getCachedFormulae() async {
    return cache.loadFormulae();
  }

  Future<List<Cask>> getCachedCasks() async {
    return cache.loadCasks();
  }

  Future<List<Formula>> getFormulae() async {
    return cache.saveFormulae(
      await api.fetchFormulae(),
    );
  }

  Future<List<Cask>> getCasks() async {
    return cache.saveCasks(
      await api.fetchCasks(),
    );
  }
}
