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

    // List usedStages = user.usedStages!;

    List usedStages = [
      "ΑΗΡ",
      "ΑΕΛ",
      "ΑΕΜ",
      "ΑΕΠ",
      "ΑΟΠ",
      "ΑΠΩ",
      "ΑΕΣ",
      "ΑΒΙ",
      "ΔΗΩ",
      "ΑΕΝ",
      "ΔΕΩ",
      "ΕΝΤ",
      "ΕΝΩ",
      "ΕΞΩ",
      "ΕΣΩ",
      "ΖΟΩ",
      "ΗΣΩ",
      "ΕΘΟ",
      "ΑΙΝ",
      "ΙΟΣ",
      "ΙΚΤ",
      "ΚΟΥ",
      "ΑΛΟ",
      "ΑΜΤ",
      "ΑΜΧ",
      "ΑΜΩ",
      "ΜΟΥ",
      "ΝΟΩ",
      "ΝΟΤ",
      "ΗΟΡ",
      "ΟΣΥ",
      "ΟΥΦ",
      "ΟΠΥ",
      "ΠΣΩ",
      "ΙΡΣ",
      "ΕΣΤ",
      "ΙΚΣ",
      "ΑΣΤ",
      "ΗΣΤ",
    ];

    banned ??= [];

    for (var i = 0; i < banned.length; i++) {
      usedStages.add(banned[i]);
    }

    do {
      returnStageList =
          await navigateToStage(context, stageWordLength, usedStages);

      if (returnStageList.isEmpty) {
        print('EINAI FULLLLLLLLLLLLLLLLLLLLLLLL');
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
    ),
  );
}
