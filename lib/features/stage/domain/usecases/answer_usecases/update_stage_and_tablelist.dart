import 'package:hive/hive.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../current_stage.dart';

Future updateStageAndTablelist({
  required List<String> tblList,
  required List positionsForChange,
  required String newWord,
}) async {
  var stageBox = Hive.box<CurrentStage>(currentStageBox);

  var stage = stageBox.get(currentStageBox);

  for (var i = 0; i < positionsForChange.length; i++) {
    tblList[positionsForChange[i]] = newWord[i];
  }

  stageBox.put(
    currentStageBox,
    CurrentStage(
      answeredPositions: stage!.answeredPositions,
      answeredWords: stage.answeredWords,
      unavailablePositions: stage.unavailablePositions,
      key: stage.key,
      allStageWords: stage.allStageWords,
      tableList: tblList,
      wordPositions: stage.wordPositions,
      timerOfStage: stage.timerOfStage,
    ),
  );
}
