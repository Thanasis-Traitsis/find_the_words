import '../../../../core/constants/constants.dart';

Map stageRequirementsBasedOnLevel({
  required int level,
  required double progress,
}) {
  const Map<int, Map<String, dynamic>> levelRules = {
    1: {
      "high": [2, 3],
      "mid": [2, 3],
      "low": [2, 3]
    },
    2: {
      "high": [5, 7],
      "mid": [4, 6],
      "low": [3, 5]
    },
    3: {
      "high": [5, 8],
      "mid": [5, 7],
      "low": [4, 6]
    },
    4: {
      "high": [6, 9, 2],
      "mid": [6, 8],
      "low": [5, 6]
    },
    5: {
      "high": [7, 10, 2],
      "mid": [6, 9],
      "low": [5, 7]
    },
    6: {
      "high": [7, 10, 2, 4],
      "mid": [7, 9],
      "low": [6, 8]
    },
    7: {
      "high": [8, 11, 2, 4],
      "mid": [7, 10, 2],
      "low": [7, 8, 2]
    },
    8: {
      "high": [9, 12, 3, 5],
      "mid": [8, 11, 2, 4],
      "low": [7, 10, 2, 4]
    },
  };

  var rules = levelRules[level];
  rules ??= levelRules[2]!;

  String progressType = (progress > highProgress)
      ? 'high'
      : (progress > midProgress)
          ? 'mid'
          : 'low';

  return {
    "minStageLength": rules[progressType]![0],
    "maxStageLength": rules[progressType]![1],
    "amountOfBigWords":
        rules[progressType]!.length > 2 ? rules[progressType]![2] : 1,
    "smallWordsLength":
        rules[progressType]!.length > 3 ? rules[progressType]![3] : 3,
  };
}
