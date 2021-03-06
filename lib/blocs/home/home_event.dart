part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class HomeChangePageEvent extends HomeEvent {
  final int index;

  HomeChangePageEvent(this.index);

  @override
  List<Object?> get props => [index];
}
