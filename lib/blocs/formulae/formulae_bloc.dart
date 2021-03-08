import 'package:brewery/models/formula.dart';
import 'package:brewery/repositories/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'formulae_event.dart';
part 'formulae_state.dart';

class FormulaeBloc extends Bloc<FormulaeEvent, FormulaeState> {
  final ApiRepository repository;

  FormulaeBloc({required this.repository}) : super(FormulaeLoadingState()) {
    add(FormulaeLoadEvent());
  }

  @override
  Stream<FormulaeState> mapEventToState(FormulaeEvent event) async* {
    if (event is FormulaeLoadEvent) {
      try {
        yield FormulaeLoadingState();
        final formulae = await repository.getFormulae();
        yield FormulaeLoadedState(
          formulae: formulae,
        );
      } catch (e, s) {
        yield FormulaeErrorState(e);
        addError(e, s);
      }
    }
  }
}