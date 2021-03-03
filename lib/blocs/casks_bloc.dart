import 'package:brewery/events/casks_events.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:brewery/states/casks_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      } catch (e) {
        yield CasksErrorState(e);
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
