import 'package:hive/hive.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../current_stage.dart';

Future saveAnswerWord({
  required List ansPos,
  required List ansWord,
  required List unavaPos,
}) async {
  var stageBox = Hive.box<CurrentStage>(currentStageBox);

  var stage = stageBox.get(currentStageBox);

  stageBox.put(
    currentStageBox,
    CurrentStage(
      answeredPositions: ansPos,
      answeredWords: ansWord,
      unavailablePositions: unavaPos,
      key: stage!.key,
      allStageWords: stage.allStageWords,
      tableList: stage.tableList,
      wordPositions: stage.wordPositions,
    ),
  );
}
