import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  SoundBloc() : super(SoundState()) {
    on<ChangeSound>(onChangeSound);
  }

  onChangeSound(ChangeSound event, Emitter<SoundState> emit) async {
    print(state.hasSound);
    emit(SoundState(hasSound: !state.hasSound));
  }
}
