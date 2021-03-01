import 'package:brewery/blocs/casks_events.dart';
import 'package:brewery/blocs/casks_states.dart';
import 'package:brewery/models/cask.dart';
import 'package:brewery/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasksBloc extends Bloc<CasksEvent, CasksState> {
  List<Cask> _casks;

  CasksBloc() : super(CasksLoadingState());

  @override
  Stream<CasksState> mapEventToState(CasksEvent event) async* {
    if (event is CasksRequestEvent) {
      try {
        yield CasksLoadingState();
        _casks = await ApiService.fetchCasks();
        yield CasksReadyState(filteredCasks: _casks, allCasks: _casks);
      } catch (e) {
        yield CasksErrorState(object: e);
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
