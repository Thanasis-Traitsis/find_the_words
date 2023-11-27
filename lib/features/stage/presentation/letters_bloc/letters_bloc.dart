import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'letters_event.dart';
part 'letters_state.dart';

class LettersBloc extends Bloc<LettersEvent, LettersState> {
  LettersBloc() : super(const LettersState()) {
    on<SetLetters>(onSetLetters);
  }

  onSetLetters(SetLetters event, Emitter<LettersState> emit) async {
    emit(state.copyWith(letters: event.letters));
  }
}
