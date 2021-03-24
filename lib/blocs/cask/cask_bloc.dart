import 'package:brewery/models/cask.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cask_event.dart';
part 'cask_state.dart';

class CaskBloc extends Bloc<CaskEvent, CaskState> {
  final ApiRepository repository;

  CaskBloc({required this.repository}) : super(CaskIdleState());

  @override
  Stream<CaskState> mapEventToState(CaskEvent event) async* {
    if (event is CaskLoadEvent) {
      try {
        yield CaskLoadingState();
        yield CaskLoadedState(
          cask: await repository.getCask(event.token),
        );
      } catch (e, s) {
        yield CaskErrorState(e);
        addError(e, s);
      }
    }
  }
}
