part of 'stage_timer_bloc.dart';

class StageTimerState extends Equatable {
  StageTimerState({
    int? timerValue,
  }) : timerValue = timerValue ?? 0;

  final int timerValue;

  @override
  List<Object> get props => [timerValue];

  StageTimerState copyWith({int? timerValue}) {
    return StageTimerState(
      timerValue: timerValue ?? this.timerValue,
    );
  }
}