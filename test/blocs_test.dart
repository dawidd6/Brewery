import 'package:bloc_test/bloc_test.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  late ApiRepository repository;

  group('returns empty list', () {
    setUp(() {
      repository = MockApiRepository();
      when(() => repository.getFormulae()).thenAnswer((_) async => []);
    });

    blocTest(
      'loading loaded',
      build: () => FormulaeBloc(repository: repository),
      expect: () => [
        FormulaeLoadingState(),
        FormulaeLoadedState(formulae: [], cached: false),
      ],
    );
  });

  group('throws error', () {
    setUp(() {
      repository = MockApiRepository();
      when(() => repository.getFormulae()).thenThrow('e');
    });

    blocTest(
      'loading error',
      build: () => FormulaeBloc(repository: repository),
      expect: () => [
        FormulaeLoadingState(),
        FormulaeErrorState('e'),
      ],
    );
  });
}
