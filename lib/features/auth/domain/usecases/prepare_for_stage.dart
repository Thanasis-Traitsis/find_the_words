import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../stage/presentation/stage_bloc/stage_bloc.dart';
import '../../data/models/user_model.dart';
import 'navigate_to_stage.dart';
import 'translate_level_to_stage.dart';

void prepareForStage({
  required BuildContext context,
  required UserModel user,
  required Map current,
}) async {

  if (current[key] == null || current[key] == '') {
    String stageWordLength = translateLevelToStage(user.level!);

    List usedStages = user.usedStages!;

    var returnStageList;

    do {
      returnStageList = await navigateToStage(context, stageWordLength);
    } while (usedStages.contains(returnStageList.keys.first));

    BlocProvider.of<StageBloc>(context).add(
      StageButtonPressed(
        stageList: returnStageList,
        level: user.level!,
        progress: user.progress!,
      ),
    );
  } else {
    BlocProvider.of<StageBloc>(context).add(
      StageButtonPressed(
        stageList: const {},
        level: user.level!,
        progress: user.progress!,
      ),
    );
  }
}
