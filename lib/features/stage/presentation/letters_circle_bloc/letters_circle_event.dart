part of 'letters_circle_bloc.dart';

sealed class LettersCircleEvent extends Equatable {
  const LettersCircleEvent();

  @override
  List<Object> get props => [];
}

class ShuffleButtonPressed extends LettersCircleEvent {
  final String letters;

  const ShuffleButtonPressed({
    required this.letters,
  });

  @override
  List<Object> get props => [letters];

  @override
  String toString() => 'ShuffleButtonPressed(letters: $letters)';
}