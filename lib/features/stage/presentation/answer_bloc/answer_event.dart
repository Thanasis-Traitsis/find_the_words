// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'answer_bloc.dart';

sealed class AnswerEvent extends Equatable {
  const AnswerEvent();

  @override
  List<Object> get props => [];
}

class AnswerLetterHover extends AnswerEvent {
  final String letter;

  const AnswerLetterHover({
    required this.letter,
  });

  @override
  List<Object> get props => [letter];

  @override
  String toString() => 'AnswerLetterHover(letter: $letter)';
}

class AnswerCompleted extends AnswerEvent {
  final Map stageMap;
  final Map answeredPositions;

  const AnswerCompleted({
    required this.stageMap,
    required this.answeredPositions,
  });

  @override
  List<Object> get props => [stageMap, answeredPositions];

  @override
  String toString() =>
      'AnswerCompleted(stageMap: $stageMap, answeredPositions: $answeredPositions)';
}

class HintCalled extends AnswerEvent {
  final Map stageMap;
  final Map answeredPositions;

  const HintCalled({
    required this.stageMap,
    required this.answeredPositions,
  });

  @override
  List<Object> get props => [stageMap, answeredPositions];

  @override
  String toString() =>
      'HintCalled(stageMap: $stageMap, answeredPositions: $answeredPositions)';
}
