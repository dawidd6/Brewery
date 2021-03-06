import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, int> {
  HomeBloc() : super(0);

  @override
  Stream<int> mapEventToState(HomeEvent event) async* {
    if (event is HomeChangePageEvent) {
      yield event.index;
    }
  }
}
