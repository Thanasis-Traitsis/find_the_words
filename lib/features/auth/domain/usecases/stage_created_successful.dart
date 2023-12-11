import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/routes_utils.dart';
import '../../../stage/presentation/answer_bloc/answer_bloc.dart';
import '../../../stage/presentation/clickable_stage_bloc/clickable_stage_bloc.dart';
import '../../../stage/presentation/crossword_table_bloc/crossword_table_bloc.dart';
import '../../../stage/presentation/letters_bloc/letters_bloc.dart';
import '../../../stage/presentation/stage_bloc/stage_bloc.dart';
import '../../data/models/user_model.dart';

void stageCreatedSuccessful({
  required BuildContext context,
  required StageStarted state,
  required Map currentStage,
  required UserModel user,
}) {
  BlocProvider.of<ClickableStageBloc>(context).add(
    const ChangeAbsorb(absorb: false),
  );

  BlocProvider.of<AnswerBloc>(context).add(AnswerInitialize());

  BlocProvider.of<CrosswordTableBloc>(context)
      .add(UpdateWidgetList(list: state.widgetList));

  BlocProvider.of<LettersBloc>(context).add(SetLetters(letters: state.letters));

  Map stageMap = {
    "allStageWords": state.allStageWords,
    "tableList": state.tableList,
    "wordPositions": state.wordPostition,
  };

  currentStage['key'] = state.letters;

  // print(user);
  // print(stageMap);
  // print(currentStage);

  context.pushNamed(
    PAGES.stage.screenName,
    extra: [
      user.stage.toString(),
      stageMap,
      currentStage,
      user,
    ],
  );
}
