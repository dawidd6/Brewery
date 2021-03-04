import 'package:bloc_test/bloc_test.dart';
import 'package:brewery/blocs/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeBloc', () {
    blocTest(
      'change',
      build: () => HomeBloc(),
      act: (HomeBloc bloc) => bloc.change(1),
      expect: () => [1],
    );
  });
}
