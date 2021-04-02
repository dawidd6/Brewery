import 'package:bloc_test/bloc_test.dart';
import 'package:brewery/blocs/casks/casks_bloc.dart';
import 'package:brewery/blocs/formulae/formulae_bloc.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/models/formula.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiRepository extends Mock implements ApiRepository {}

class MockFormula extends Mock implements Formula {}

class MockCask extends Mock implements Cask {}

void main() {
  group('returns empty cached data', () {
    final repository = MockApiRepository();
    when(() => repository.getCachedFormulae()).thenAnswer((_) async => []);
    when(() => repository.getCachedCasks()).thenAnswer((_) async => []);

    blocTest(
      'empty cached formulae results loading loaded',
      build: () =>
          FormulaeBloc(repository: repository)..add(FormulaeLoadEvent()),
      expect: () => [
        FormulaeLoadingState(),
        FormulaeLoadedState(formulae: [], cached: true),
      ],
    );

    blocTest(
      'empty cached casks results loading loaded',
      build: () => CasksBloc(repository: repository)..add(CasksLoadEvent()),
      expect: () => [
        CasksLoadingState(),
        CasksLoadedState(casks: [], cached: true),
      ],
    );
  });

  group('returns empty data', () {
    final repository = MockApiRepository();
    when(() => repository.getCachedFormulae()).thenThrow('');
    when(() => repository.getCachedCasks()).thenThrow('');
    when(() => repository.getFormulae()).thenAnswer((_) async => []);
    when(() => repository.getCasks()).thenAnswer((_) async => []);

    blocTest(
      'empty formulae results loading loaded',
      build: () =>
          FormulaeBloc(repository: repository)..add(FormulaeLoadEvent()),
      expect: () => [
        FormulaeLoadingState(),
        FormulaeLoadedState(formulae: []),
      ],
    );

    blocTest(
      'empty casks results loading loaded',
      build: () => CasksBloc(repository: repository)..add(CasksLoadEvent()),
      expect: () => [
        CasksLoadingState(),
        CasksLoadedState(casks: []),
      ],
    );
  });

  group('returns old cached data', () {
    final formula = MockFormula();
    final cask = MockCask();
    final repository = MockApiRepository();
    when(() => repository.getCachedFormulae()).thenThrow('');
    when(() => repository.getCachedCasks()).thenThrow('');
    when(() => repository.getFormulae()).thenThrow('');
    when(() => repository.getCasks()).thenThrow('');
    when(() => repository.getOldCachedFormulae())
        .thenAnswer((_) async => [formula]);
    when(() => repository.getOldCachedCasks()).thenAnswer((_) async => [cask]);

    blocTest(
      'old cached formulae results loading loaded',
      build: () =>
          FormulaeBloc(repository: repository)..add(FormulaeLoadEvent()),
      expect: () => [
        FormulaeLoadingState(),
        FormulaeLoadedState(formulae: [formula], cached: true, old: true),
      ],
    );

    blocTest(
      'old cached casks results loading loaded',
      build: () => CasksBloc(repository: repository)..add(CasksLoadEvent()),
      expect: () => [
        CasksLoadingState(),
        CasksLoadedState(casks: [cask], cached: true, old: true),
      ],
    );
  });

  group('returns cached data', () {
    final formula = MockFormula();
    final cask = MockCask();
    final repository = MockApiRepository();
    when(() => repository.getCachedFormulae())
        .thenAnswer((_) async => [formula]);
    when(() => repository.getCachedCasks()).thenAnswer((_) async => [cask]);

    blocTest(
      'cached formulae results loading loaded',
      build: () =>
          FormulaeBloc(repository: repository)..add(FormulaeLoadEvent()),
      expect: () => [
        FormulaeLoadingState(),
        FormulaeLoadedState(formulae: [formula], cached: true),
      ],
    );

    blocTest(
      'cached casks results loading loaded',
      build: () => CasksBloc(repository: repository)..add(CasksLoadEvent()),
      expect: () => [
        CasksLoadingState(),
        CasksLoadedState(casks: [cask], cached: true),
      ],
    );
  });

  group('returns data', () {
    final formula = MockFormula();
    final cask = MockCask();
    final repository = MockApiRepository();
    when(() => repository.getCachedFormulae()).thenThrow('');
    when(() => repository.getCachedCasks()).thenThrow('');
    when(() => repository.getFormulae()).thenAnswer((_) async => [formula]);
    when(() => repository.getCasks()).thenAnswer((_) async => [cask]);

    blocTest(
      'formulae results loading loaded',
      build: () =>
          FormulaeBloc(repository: repository)..add(FormulaeLoadEvent()),
      expect: () => [
        FormulaeLoadingState(),
        FormulaeLoadedState(formulae: [formula]),
      ],
    );

    blocTest(
      'casks results loading loaded',
      build: () => CasksBloc(repository: repository)..add(CasksLoadEvent()),
      expect: () => [
        CasksLoadingState(),
        CasksLoadedState(casks: [cask]),
      ],
    );
  });

  group('throws error', () {
    final repository = MockApiRepository();
    when(() => repository.getCachedFormulae()).thenThrow('');
    when(() => repository.getCachedCasks()).thenThrow('');
    when(() => repository.getFormulae()).thenThrow('');
    when(() => repository.getCasks()).thenThrow('');
    when(() => repository.getOldCachedFormulae()).thenThrow('e');
    when(() => repository.getOldCachedCasks()).thenThrow('e');

    blocTest(
      'formulae loading error',
      build: () =>
          FormulaeBloc(repository: repository)..add(FormulaeLoadEvent()),
      expect: () => [
        FormulaeLoadingState(),
        FormulaeErrorState('e'),
      ],
    );

    blocTest(
      'casks loading error',
      build: () => CasksBloc(repository: repository)..add(CasksLoadEvent()),
      expect: () => [
        CasksLoadingState(),
        CasksErrorState('e'),
      ],
    );
  });
}
