import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'current_stage.g.dart';

@HiveType(typeId: 1)
class CurrentStage {
  CurrentStage({
    required this.answeredPositions,
    required this.answeredWords,
    required this.unavailablePositions,
    required this.key,
    required this.allStageWords,
    required this.tableList,
    required this.wordPositions,
    required this.timerOfStage,
  });

  @override
  String toString() {
    return 'CurrentStage{'
        'answeredPositions: $answeredPositions, '
        'answeredWords: $answeredWords, '
        'unavailablePositions: $unavailablePositions, '
        'key: $key, '
        'allStageWords: $allStageWords, '
        'tableList: $tableList, '
        'wordPositions: $wordPositions, '
        'timerOfStage: $timerOfStage}';
  }

  @HiveField(0)
  List answeredWords;

  @HiveField(1)
  List answeredPositions;

  @HiveField(2)
  List unavailablePositions;

  @HiveField(3)
  String? key;

  @HiveField(5)
  List<String>? tableList;

  @HiveField(6)
  List? wordPositions;

  @HiveField(7)
  List? allStageWords;

  @HiveField(8)
  int? timerOfStage;
}
