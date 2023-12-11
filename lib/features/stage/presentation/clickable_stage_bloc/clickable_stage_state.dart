part of 'clickable_stage_bloc.dart';

class ClickableStageState extends Equatable {
  const ClickableStageState({
    bool? absorb,
  }) : absorb = absorb ?? false;

  final bool absorb;

  @override
  List<Object> get props => [absorb];

  ClickableStageState copyWith({bool? absorb}) {
    return ClickableStageState(
      absorb: absorb ?? this.absorb,
    );
  }
}
