part of 'scrollable_bloc.dart';

sealed class ScrollableEvent extends Equatable {
  const ScrollableEvent();

  @override
  List<Object> get props => [];
}

class UpdateScrollableStageScreen extends ScrollableEvent {
  final bool scrollable;

  const UpdateScrollableStageScreen({
    required this.scrollable,
  });

  @override
  List<Object> get props => [scrollable];
}