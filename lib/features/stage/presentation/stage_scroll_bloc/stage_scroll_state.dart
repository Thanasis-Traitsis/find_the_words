part of 'stage_scroll_bloc.dart';

class StageScrollState extends Equatable {
  StageScrollState({
    bool? scrollable,
  }) : scrollable = scrollable ?? true;

  final bool scrollable;

  @override
  List<Object> get props => [scrollable];

  StageScrollState copyWith({bool? scrollable}) {
    return StageScrollState(
      scrollable: scrollable ?? this.scrollable,
    );
  }
}
