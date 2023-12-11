import 'package:hive/hive.dart';

import '../../../../core/constants/constants.dart';
import '../../../../current_stage.dart';

Future getCurrentStageMap() async {
  var stageBox = Hive.box<CurrentStage>(currentStageBox);
  Map currentStage = {};

  // await stageBox.delete(currentStageBox);

  var stage = stageBox.get(currentStageBox);

  if (stage == null || stage.key == null) {
    stageBox.put(
      currentStageBox,
      CurrentStage(
        answeredPositions: [],
        answeredWords: [],
        unavailablePositions: [],
        key: null,
        allStageWords: [],
        tableList: [],
        wordPositions: [],
        timerOfStage: 0,
      ),
    );

    stage = stageBox.get(currentStageBox);
  }

  currentStage = {
    answeredPositions: stage!.answeredPositions,
    answeredWords: stage.answeredWords,
    unavailablePositions: stage.unavailablePositions,
    key: stage.key,
    currentTimer: stage.timerOfStage,
  };

  return currentStage;
}
