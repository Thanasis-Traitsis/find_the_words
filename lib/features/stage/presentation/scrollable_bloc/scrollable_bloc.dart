import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scrollable_event.dart';
part 'scrollable_state.dart';

class ScrollableBloc
    extends Bloc<ScrollableEvent, ScrollableState> {
  ScrollableBloc() : super(ScrollableState()) {
    on<UpdateScrollableStageScreen>(onUpdateScrollableStageScreen);
  }

  onUpdateScrollableStageScreen(
      UpdateScrollableStageScreen event, Emitter<ScrollableState> emit) async {
    emit(state.copyWith(scrollable: event.scrollable));
  }
}

