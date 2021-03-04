import 'package:brewery/models/cask.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CasksEvent extends Equatable {}

abstract class CasksState extends Equatable {}

class CasksRequestEvent extends CasksEvent {
  @override
  List<Object?> get props => [];
}

class CasksFilterEvent extends CasksEvent {
  final String filter;

  CasksFilterEvent({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class CasksLoadingState extends CasksState {
  @override
  List<Object?> get props => [];
}

class CasksReadyState extends CasksState {
  final List<Cask> allCasks;
  final List<Cask> filteredCasks;

  CasksReadyState({
    required this.filteredCasks,
    required this.allCasks,
  });

  @override
  List<Object?> get props => [allCasks, filteredCasks];
}

class CasksErrorState extends CasksState {
  final Object error;

  CasksErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class CasksBloc extends Bloc<CasksEvent, CasksState> {
  List<Cask> _casks = [];
  final ApiRepository repository;

  CasksBloc({required this.repository}) : super(CasksLoadingState());

  @override
  Stream<CasksState> mapEventToState(CasksEvent event) async* {
    if (event is CasksRequestEvent) {
      try {
        yield CasksLoadingState();
        _casks = await repository.getCasks();
        yield CasksReadyState(
          filteredCasks: _casks,
          allCasks: _casks,
        );
      } catch (e, s) {
        yield CasksErrorState(e);
        addError(e, s);
      }
    } else if (event is CasksFilterEvent) {
      yield CasksReadyState(
        allCasks: _casks,
        filteredCasks: _casks
            .where(
              (cask) => cask.token.contains(
                RegExp(event.filter),
              ),
            )
            .toList(),
      );
    }
  }
}
