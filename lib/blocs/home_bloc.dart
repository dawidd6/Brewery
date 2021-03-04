import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeEvent extends Equatable {}

abstract class HomeState extends Equatable {}

class HomeChangePageEvent extends HomeEvent {
  final int index;

  HomeChangePageEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class HomePageState extends HomeState {
  final int index;

  HomePageState(this.index);

  @override
  List<Object?> get props => [index];
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomePageState(0));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeChangePageEvent) {
      yield HomePageState(event.index);
    }
  }
}
