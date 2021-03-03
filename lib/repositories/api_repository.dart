import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/services/api_service.dart';

class ApiRepository {
  final ApiService service;

  ApiRepository({
    required this.service,
  });

  Future<List<Formula>> getFormulae() async {
    return service.fetchFormulae();
  }

  Future<List<Cask>> getCasks() async {
    return service.fetchCasks();
  }
}
