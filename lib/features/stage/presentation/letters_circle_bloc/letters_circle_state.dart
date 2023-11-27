part of 'letters_circle_bloc.dart';

sealed class LettersCircleState extends Equatable {
  const LettersCircleState();

  @override
  List<Object> get props => [];
}

final class LettersCircleInitial extends LettersCircleState {}

final class LettersCircleShuffle extends LettersCircleState {
  final String letters;

  const LettersCircleShuffle({
    required this.letters,
  });

  @override
  List<Object> get props => [letters];

  @override
  String toString() => 'LettersCircleShuffle(letters: $letters)';
}
