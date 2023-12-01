// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:find_the_words/features/auth/domain/usecases/get_current_stage_map.dart';
import 'package:find_the_words/features/auth/domain/usecases/prepare_for_stage.dart';
import 'package:find_the_words/features/auth/presentation/widgets/blue_home_card.dart';
import 'package:find_the_words/features/auth/presentation/widgets/green_home_card.dart';
import 'package:find_the_words/features/auth/presentation/widgets/home_button.dart';
import 'package:find_the_words/features/auth/presentation/widgets/home_landscape_container.dart';
import 'package:find_the_words/features/stage/presentation/answer_bloc/answer_bloc.dart';
import 'package:find_the_words/features/stage/presentation/crossword_table_bloc/crossword_table_bloc.dart';
import 'package:find_the_words/features/stage/presentation/letters_bloc/letters_bloc.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/utils/breakpoints_utils.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../stage/presentation/stage_bloc/stage_bloc.dart';
import '../../data/models/user_model.dart';
import '../widgets/home_background.dart';
import '../widgets/home_cards_container.dart';
import '../widgets/home_landscape_background.dart';
import '../widgets/logo_container.dart';
import '../widgets/pink_home_card.dart';

class HomeScreen extends StatelessWidget {
  UserModel user;

  HomeScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = getDeviceOrientation(context);

    Map currentStage = {};

    onStageButtonPressed() async {
      // Get current stage lists
      currentStage = await getCurrentStageMap();

      prepareForStage(
        context: context,
        user: user,
        current: currentStage,
      );
    }

    return BlocListener<StageBloc, StageState>(
      listener: (context, state) {
        if (state is StageStarted) {
          BlocProvider.of<AnswerBloc>(context).add(AnswerInitialize());

          BlocProvider.of<CrosswordTableBloc>(context)
              .add(UpdateWidgetList(list: state.widgetList));

          BlocProvider.of<LettersBloc>(context)
              .add(SetLetters(letters: state.letters));

          Map stageMap = {
            "allStageWords": state.allStageWords,
            "tableList": state.tableList,
            "wordPositions": state.wordPostition,
          };

          currentStage['key'] = state.letters;

          print(user);
          print(stageMap);
          print(currentStage);

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
                          isPorttrait: false,
                        ),
                        const SizedBox(
                          height: gap / 2,
                        ),
                        BlueHomeCard(
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
