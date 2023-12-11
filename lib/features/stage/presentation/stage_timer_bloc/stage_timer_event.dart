part of 'stage_timer_bloc.dart';

sealed class StageTimerEvent extends Equatable {
  const StageTimerEvent();

  @override
  List<Object> get props => [];
}

class GetTimerValue extends StageTimerEvent {
  final int timer;

  const GetTimerValue({
    required this.timer,
  });

  @override
  List<Object> get props => [timer];
}