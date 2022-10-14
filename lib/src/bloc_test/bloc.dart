import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class Bloc_testBloc extends Bloc<Bloc_testEvent, Bloc_testState> {
  Bloc_testBloc() : super(Bloc_testState().init());

  @override
  Stream<Bloc_testState> mapEventToState(Bloc_testEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<Bloc_testState> init() async {
    return state.clone();
  }
}
