import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'clickable_stage_event.dart';
part 'clickable_stage_state.dart';

class ClickableStageBloc extends Bloc<ClickableStageEvent, ClickableStageState> {
  ClickableStageBloc() : super(const ClickableStageState()) {
    on<ChangeAbsorb>(onChangeAbsorb);
  }

  onChangeAbsorb(ChangeAbsorb event, Emitter<ClickableStageState> emit) async {
    emit(state.copyWith(absorb: event.absorb));
  }
}
