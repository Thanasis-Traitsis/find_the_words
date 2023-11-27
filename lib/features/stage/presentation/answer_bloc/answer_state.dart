part of 'answer_bloc.dart';

sealed class AnswerState extends Equatable {
  const AnswerState();

  @override
  List<Object> get props => [];
}

final class AnswerInitial extends AnswerState {}

final class AnswerCreation extends AnswerState {}

final class AnswerComplete extends AnswerState {
  final String answer;

  const AnswerComplete({
    required this.answer,
  });

  @override
  List<Object> get props => [answer];

  @override
  String toString() => 'LettersCircleShuffle(answers: $answer)';
}

final class AnswerCorrect extends AnswerState {
  final List positions;
  final String word;

  const AnswerCorrect({
    required this.positions,
    required this.word,
  });

  @override
  List<Object> get props => [
        positions,
        word,
      ];

  @override
  String toString() =>
      'LettersCircleShuffle(positions: $positions, word: $word)';
}
