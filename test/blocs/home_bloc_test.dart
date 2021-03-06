import 'package:bloc_test/bloc_test.dart';
import 'package:brewery/blocs/home/home_bloc.dart';

void main() {
  blocTest(
    'change page',
    build: () => HomeBloc(),
    act: (HomeBloc bloc) => bloc.add(HomeChangePageEvent(1)),
    expect: () => [1],
  );
}
