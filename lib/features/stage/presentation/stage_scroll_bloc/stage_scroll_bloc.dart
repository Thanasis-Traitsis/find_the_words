import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stage_scroll_event.dart';
part 'stage_scroll_state.dart';

class StageScrollBloc extends Bloc<StageScrollEvent, StageScrollState> {
  StageScrollBloc() : super(StageScrollState()) {
    on<UpdateScrollableStageScreen>(onUpdateScrollableStageScreen);
  }

  onUpdateScrollableStageScreen(
      UpdateScrollableStageScreen event, Emitter<StageScrollState> emit) async {
    emit(state.copyWith(scrollable: event.scrollable));
  }
}
