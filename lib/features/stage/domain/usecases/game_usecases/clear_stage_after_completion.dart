import 'package:find_the_words/core/utils/routes_utils.dart';
import 'package:find_the_words/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:find_the_words/features/complete/domain/usecases/calculating_progress/calculating_the_progress.dart';
import 'package:find_the_words/features/complete/domain/usecases/calculating_progress/find_smaller_and_bigger_word.dart';
import 'package:find_the_words/features/complete/domain/usecases/convert_extra_words_to_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../current_stage.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/presentation/points_bloc/points_bloc.dart';
import '../../../../complete/domain/usecases/calculating_points_for_level_up.dart';
import '../../../../complete/domain/usecases/convert_stage_words_to_points.dart';
import '../../../presentation/clickable_stage_bloc/clickable_stage_bloc.dart';
import 'extra_words_repositories.dart';

Future clearStageAfterCompletion({
  required BuildContext context,
  required String key,
}) async {
  final authRepositoriesImpl = AuthRepositoriesImpl();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var stageBox = Hive.box<CurrentStage>(currentStageBox);
  var stage = stageBox.get(currentStageBox);

  // Try reading data from the 'items' key. If it doesn't exist, returns null.
  List<String>? extraWords = prefs.getStringList(extraWordsList);
  List<String>? words = prefs.getStringList(allWords);
  int? points = prefs.getInt(userPoints);

  extraWords ??= [];
  words ??= [];
  points ??= 0;

  await authRepositoriesImpl.getUser();
  UserModel? user = authRepositoriesImpl.user;

  // Here we save all the old values that we need to show in the complete stage screen
  int oldLevel = user!.level!;
  int oldStage = user.stage!;
  int wordsUsedInStage = stage!.wordPositions!.length;
  int extraWordsFound = extraWords.length;

  List smallAndBigResult = findSmallerAndBiggerWord(stage.wordPositions!);
  int smallest = smallAndBigResult[0];
  int biggest = smallAndBigResult[1];

  int secondsCount = stage.timerOfStage!;

  double calcProg = await calculatingTheProgress(
    secondsCount: secondsCount,
    context: context,
    stageWordsLength: stage.allStageWords!.length,
    biggestWordLength: biggest,
    crosswordLength: wordsUsedInStage,
    extraWordsLength: extraWordsFound,
    smallestWordLength: smallest,
    letters: key,
  );

  // Calculating the progress
  double prog = user.progress! + calcProg;
  int levelUpPoints = 0;

  print(prog);

  if (prog >= 1 && (oldLevel < maxLevel)) {
    levelUpPoints = calculatingPointsForLevelUp(oldLevel);
  }

  // Updating the user
  await authRepositoriesImpl.updateUserAfterStage(
    userStage: user,
    stageKey: key,
    allTheWords: words,
    userPoints: points,
    progress: prog,
    levelUp: oldLevel < maxLevel ? prog >= 1 : false,
  );

  user = authRepositoriesImpl.user;

  // Add the sum points
  int sum = (convertStageWordsToPoints(wordsUsedInStage) +
      convertExtraWordsToPoints(extraWordsFound) +
      oldLevel +
      levelUpPoints);

  BlocProvider.of<PointsBloc>(context).add(
    ChangePoints(
      points: sum,
      isMinus: false,
    ),
  );

  // Clearing the stage
  await clearExtraWord();
  await stageBox.delete(currentStageBox);

  BlocProvider.of<ClickableStageBloc>(context)
      .add(const ChangeAbsorb(absorb: false));

  context.pushReplacementNamed(
    PAGES.complete.screenName,
    extra: {
      completeStageLevel: oldLevel,
      completeStageStage: oldStage,
      completeStageProgress: prog,
      completeStageWordsUsedInStage:
          convertStageWordsToPoints(wordsUsedInStage),
      completeStageExtraWordsFound: convertExtraWordsToPoints(extraWordsFound),
      completeStageStageCompletion: oldLevel,
      completeStageLevelUp: prog >= 1,
      completeStageLevelUpPoints: levelUpPoints,
      completeStageSumOfPoints: sum,
      completeStageUser: user,
    },
  );
}
