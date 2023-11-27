import 'package:find_the_words/features/auth/domain/usecases/translate_level_to_stage.dart';
import 'package:find_the_words/features/auth/presentation/widgets/blue_home_card.dart';
import 'package:find_the_words/features/auth/presentation/widgets/green_home_card.dart';
import 'package:find_the_words/features/auth/presentation/widgets/home_button.dart';
import 'package:find_the_words/features/auth/presentation/widgets/home_landscape_container.dart';
import 'package:find_the_words/features/stage/presentation/crossword_table_bloc/crossword_table_bloc.dart';
import 'package:find_the_words/features/stage/presentation/letters_bloc/letters_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils/breakpoints_utils.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../stage/presentation/stage_bloc/stage_bloc.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/navigate_to_stage.dart';
import '../widgets/home_background.dart';
import '../widgets/home_cards_container.dart';
import '../widgets/home_landscape_background.dart';
import '../widgets/logo_container.dart';
import '../widgets/pink_home_card.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  const HomeScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = getDeviceOrientation(context);

    onStageButtonPressed() async {
      String stageWordLength = translateLevelToStage(user.level!);

      List usedStages = user.usedStages!;

      var returnStageList;

      do {
        returnStageList = await navigateToStage(context, stageWordLength);
      } while (usedStages.contains(returnStageList.keys.first));

      print(returnStageList);

      BlocProvider.of<StageBloc>(context).add(
        StageButtonPressed(
          stageList: returnStageList,
          level: user.level!,
          progress: user.progress!,
        ),
      );
    }

    return BlocListener<StageBloc, StageState>(
      listener: (context, state) {
        if (state is StageStarted) {
          BlocProvider.of<CrosswordTableBloc>(context)
              .add(UpdateWidgetList(list: state.widgetList));

          BlocProvider.of<LettersBloc>(context)
              .add(SetLetters(letters: state.letters));

          context.pushNamed(
            PAGES.stage.screenName,
            extra: [
              user.stage.toString(),
              {
                "allStageWords": state.allStageWords,
                "tableList": state.tableList,
                "wordPositions": state.wordPostition,
              },
              {
                "answeredWords": [],
                "answeredPositions": [],
                "unavailablePositions": [],
              }
            ],
          );
        }

        if (state is StageFailedCreation) {
          onStageButtonPressed();
        }
      },
      child: Scaffold(
        body: deviceOrientation == DeviceOrientation.portrait
            ? HomeBackground(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LogoContainer(
                      context: context,
                    ),
                    HomeCardsContainer(
                      context: context,
                      points: user.points.toString(),
                      words: user.words!,
                      level: user.level.toString(),
                    ),
                    HomeButton(
                      context: context,
                      function: onStageButtonPressed,
                      stage: user.stage.toString(),
                    ),
                  ],
                ),
              )
            : HomeLandscapeBackground(
                children: [
                  HomeLandscapeContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PinkHomeCard(
                          context: context,
                          points: user.points.toString(),
                          isPorttrait: false,
                        ),
                        const SizedBox(
                          height: gap / 2,
                        ),
                        BlueHomeCard(
                          words: user.words!,
                          isPorttrait: false,
                        ),
                        const SizedBox(
                          height: gap / 2,
                        ),
                        GreenHomeCard(
                          context: context,
                          level: user.level.toString(),
                        ),
                      ],
                    ),
                  ),
                  HomeLandscapeContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LogoContainer(context: context),
                        HomeButton(
                          context: context,
                          function: onStageButtonPressed,
                          stage: user.stage.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
