import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stage_timer_event.dart';
part 'stage_timer_state.dart';

class StageTimerBloc extends Bloc<StageTimerEvent, StageTimerState> {
  StageTimerBloc() : super(StageTimerState()) {
    on<GetTimerValue>(onGetTimerValue);
  }

  onGetTimerValue(
      GetTimerValue event, Emitter<StageTimerState> emit) async {
    emit(state.copyWith(timerValue: event.timer));
  }
}
