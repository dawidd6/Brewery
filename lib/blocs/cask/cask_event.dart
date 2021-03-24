part of 'cask_bloc.dart';

abstract class CaskEvent extends Equatable {}

class CaskLoadEvent extends CaskEvent {
  final String token;

  CaskLoadEvent({required this.token});

  @override
  List<Object?> get props => [token];
}
