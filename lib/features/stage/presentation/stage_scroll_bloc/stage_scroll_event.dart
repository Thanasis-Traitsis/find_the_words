part of 'stage_scroll_bloc.dart';

sealed class StageScrollEvent extends Equatable {
  const StageScrollEvent();

  @override
  List<Object> get props => [];
}

class UpdateScrollableStageScreen extends StageScrollEvent {
  final bool scrollable;

  const UpdateScrollableStageScreen({
    required this.scrollable,
  });

  @override
  List<Object> get props => [scrollable];
}