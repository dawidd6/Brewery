import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/api_service.dart';

class ApiRepository {
  final ApiService api = ApiService();

  Future<List<Formula>> getFormulae() async {
    return api.fetchFormulae();
  }

  Future<List<Cask>> getCasks() async {
    return api.fetchCasks();
  }
}
