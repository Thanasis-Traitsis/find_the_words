part of 'scrollable_bloc.dart';

class ScrollableState extends Equatable {
  ScrollableState({
    bool? scrollable,
  }) : scrollable = scrollable ?? true;

  final bool scrollable;

  @override
  List<Object> get props => [scrollable];

  ScrollableState copyWith({bool? scrollable}) {
    return ScrollableState(
      scrollable: scrollable ?? this.scrollable,
    );
  }
}
