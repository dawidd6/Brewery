import 'package:brewery/models/formula.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'formulae_event.dart';
part 'formulae_state.dart';

class FormulaeBloc extends Bloc<FormulaeEvent, FormulaeState> {
  final ApiRepository repository;

  FormulaeBloc({required this.repository}) : super(FormulaeLoadingState());

  @override
  Stream<FormulaeState> mapEventToState(FormulaeEvent event) async* {
    if (event is FormulaeLoadEvent) {
      try {
        yield FormulaeLoadingState();
        try {
          yield FormulaeLoadedState(
            formulae: await repository.getCachedFormulae(),
            cached: true,
          );
        } catch (e) {
          try {
            yield FormulaeLoadedState(
              formulae: await repository.getFormulae(),
            );
          } catch (e) {
            yield FormulaeLoadedState(
              formulae: await repository.getOldCachedFormulae(),
              cached: true,
              old: true,
            );
          }
        }
      } catch (e, s) {
        yield FormulaeErrorState(e);
        addError(e, s);
      }
    }
  }
}
