import 'package:hive/hive.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../current_stage.dart';

List<String> changeCrossword(List<String> tblList) {
  var stageBox = Hive.box<CurrentStage>(currentStageBox);

  var stage = stageBox.get(currentStageBox);

  print(stage!.tableList == tblList);

  return [];
}
