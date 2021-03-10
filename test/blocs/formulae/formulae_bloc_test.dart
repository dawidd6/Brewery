import 'package:bloc_test/bloc_test.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:mockito/mockito.dart';

class MockApiRepository extends Mock implements ApiRepository {
  @override
  Future<List<Formula>> getFormulae() async {
    return [];
  }

  @override
  Future<List<Cask>> getCasks() async {
    return [];
  }
}

class MockApiRepositoryError extends Mock implements ApiRepository {
  @override
  Future<List<Formula>> getFormulae() async {
    throw 'e';
  }

  @override
  Future<List<Cask>> getCasks() async {
    throw 'e';
  }
}

void main() {
  blocTest(
    'loading loaded',
    build: () => FormulaeBloc(repository: MockApiRepository()),
    expect: () => [
      FormulaeLoadingState(),
      FormulaeLoadedState(formulae: []),
    ],
  );

  blocTest(
    'loading error',
    build: () => FormulaeBloc(repository: MockApiRepositoryError()),
    expect: () => [
      FormulaeLoadingState(),
      FormulaeErrorState('e'),
    ],
  );
}
