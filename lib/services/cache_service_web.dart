import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/cache_service.dart';

class CacheServiceWeb implements CacheService {
  @override
  Future<List<Cask>> loadOldCasks() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Formula>> loadOldFormulae() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Cask>> loadCasks() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Formula>> loadFormulae() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Cask>> saveCasks(List<Cask> casks) async {
    return casks;
  }

  @override
  Future<List<Formula>> saveFormulae(List<Formula> formulae) async {
    return formulae;
  }
}
