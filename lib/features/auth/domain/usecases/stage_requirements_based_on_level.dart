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
      "high": [6, 9],
      "mid": [6, 8],
      "low": [5, 7]
    },
    4: {
      "high": [8, 11, 2],
      "mid": [7, 10],
      "low": [6, 9]
    },
    5: {
      "high": [10, 13, 2],
      "mid": [10, 12],
      "low": [9, 11]
    },
    6: {
      "high": [11, 15, 2, 4],
      "mid": [11, 4],
      "low": [10, 13]
    },
    7: {
      "high": [14, 18, 2, 4],
      "mid": [13, 17, 2],
      "low": [12, 15, 2]
    },
    8: {
      "high": [16, 18, 2, 4],
      "mid": [15, 18, 2, 4],
      "low": [14, 18, 1, 4]
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
