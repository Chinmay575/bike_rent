import 'package:bloc/bloc.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(LandingState(index: 0)) {
    on<TabChange>((event, emit) {
      emit(LandingState(index: event.index));
    });
  }
}
