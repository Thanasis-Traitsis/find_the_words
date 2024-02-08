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
  required List? banned,
}) async {
  var returnStageList = {};

  if (current[key]?.isEmpty ?? true) {
    String stageWordLength = translateLevelToStage(user.level!);

    List usedStages = user.usedStages!;
    
    banned ??= [];

    for (var i = 0; i < banned.length; i++) {
      usedStages.add(banned[i]);
    }

    do {
      returnStageList =
          await navigateToStage(context, stageWordLength, usedStages);

      if (returnStageList.isEmpty) {
        print('The banned list with the word length of ${user.level! + 2} is full. We need to clear the list and create new stages with already used words, but with different combinations.');
        usedStages
            .removeWhere((element) => element.length == (user.level! + 2));
      }
    } while (returnStageList.isEmpty);
  }

  BlocProvider.of<StageBloc>(context).add(
    StageButtonPressed(
      stageList: returnStageList,
      level: user.level!,
      progress: user.progress!,
      current: current,
    ),
  );
}
