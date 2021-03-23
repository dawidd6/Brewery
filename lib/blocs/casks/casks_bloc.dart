import 'package:brewery/models/cask.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'casks_event.dart';
part 'casks_state.dart';

class CasksBloc extends Bloc<CasksEvent, CasksState> {
  final ApiRepository repository;

  CasksBloc({required this.repository}) : super(CasksLoadingState()) {
    add(CasksLoadEvent());
  }

  @override
  Stream<CasksState> mapEventToState(CasksEvent event) async* {
    if (event is CasksLoadEvent) {
      try {
        yield CasksLoadingState();
        try {
          yield CasksLoadedState(
            casks: await repository.getCachedCasks(),
            cached: true,
          );
        } catch (e) {
          yield CasksLoadedState(
            casks: await repository.getCasks(),
            cached: false,
          );
        }
      } catch (e, s) {
        yield CasksErrorState(e);
        addError(e, s);
      }
    }
  }
}
