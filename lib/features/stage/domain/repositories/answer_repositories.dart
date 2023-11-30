abstract class AnswerRepositories {
  Future submitAnswer({
    required String answer,
    required List wordPositions,
    required List<String> tableList,
    required List allStageWords,
    required List answeredPositions,
    required List answeredWords,
  });

  Future positionHintLetter({
    required List wordPositions,
    required List<String> tableList,
    required List answeredPositions,
    required List unavailablePositions,
  });

  Future searchForExtraWords({
    required List allStageWords,
    required String word,
  });
}
