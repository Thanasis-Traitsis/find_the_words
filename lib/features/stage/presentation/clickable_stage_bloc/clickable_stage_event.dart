part of 'clickable_stage_bloc.dart';

sealed class ClickableStageEvent extends Equatable {
  const ClickableStageEvent();

  @override
  List<Object> get props => [];
}

class ChangeAbsorb extends ClickableStageEvent {
  final bool absorb;

  const ChangeAbsorb({
    required this.absorb,
  });

  @override
  List<Object> get props => [absorb];
}
