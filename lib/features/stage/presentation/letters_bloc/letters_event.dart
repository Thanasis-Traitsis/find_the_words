part of 'letters_bloc.dart';

sealed class LettersEvent extends Equatable {
  const LettersEvent();

  @override
  List<Object> get props => [];
}

class SetLetters extends LettersEvent {
  final String letters;

  const SetLetters({
    required this.letters,
  });

  @override
  List<Object> get props => [letters];
}
