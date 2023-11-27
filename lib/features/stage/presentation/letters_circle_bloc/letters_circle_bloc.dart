import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'letters_circle_event.dart';
part 'letters_circle_state.dart';

class LettersCircleBloc extends Bloc<LettersCircleEvent, LettersCircleState> {
  LettersCircleBloc() : super(LettersCircleInitial()) {
    on<ShuffleButtonPressed>(onShuffleButtonPressed);
  }

  void onShuffleButtonPressed(
      ShuffleButtonPressed event, Emitter<LettersCircleState> emit) async {
    emit(LettersCircleInitial());

    emit(LettersCircleShuffle(letters: event.letters));
  }
}
