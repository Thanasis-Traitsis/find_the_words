// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_the_words/core/usecases/calculate_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../../core/widgets/absorb_pointer_container.dart';
import '../../../../core/widgets/card_with_outline.dart';
import '../../../auth/domain/usecases/get_current_stage_map.dart';
import '../../../auth/domain/usecases/prepare_for_stage.dart';
import '../../../stage/presentation/answer_bloc/answer_bloc.dart';
import '../../../stage/presentation/crossword_table_bloc/crossword_table_bloc.dart';
import '../../../stage/presentation/letters_bloc/letters_bloc.dart';
import '../../../stage/presentation/stage_bloc/stage_bloc.dart';
import '../widgets/complete_buttons_container.dart';
import '../widgets/level_progress_container.dart';
import '../widgets/results_container.dart';
import '../widgets/stats_header.dart';

class CompleteStageScreen extends StatelessWidget {
  final Map completeValues;

  const CompleteStageScreen({
    Key? key,
    required this.completeValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map currentStage = {};

    onStageButtonPressed(List? bannedKeys) {
      print(
          "RE TI GINETAI MIPOS TREXEI APO EDW PARA POLLES FORESSSSSSSSS ???????????????");
      prepareForStage(
        context: context,
        user: completeValues[completeStageUser],
        current: currentStage,
        banned: bannedKeys,
      );
    }

    return BlocListener<StageBloc, StageState>(
      listener: (context, state) {
        if (state is StageStarted) {
          print(
              '================================================================================');
          print(state.widgetList);

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

          print(
              '======================================================================================================');
          print(
            completeValues[completeStageUser],
          );
          print(stageMap);
          print(currentStage);

          context.pushReplacementNamed(
            PAGES.stage.screenName,
            extra: [
              completeValues[completeStageUser].stage.toString(),
              stageMap,
              currentStage,
              completeValues[completeStageUser],
            ],
          );
        }

        // if (state is StageFailedCreation) {
        //   onStageButtonPressed(state.bannedKeys);
        // }
      },
      child: AbsorbPointerContainer(
        context: context,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: calculateSize(context, 500)),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(AppValuesMain().padding),
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LevelProgressContainer(
                                    context: context,
                                    level: completeValues[completeStageLevel],
                                    progress:
                                        completeValues[completeStageProgress],
                                    stage: completeValues[completeStageStage],
                                  ),
                                  const SizedBox(
                                    height: gap,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        completeValues[completeStageLevelUp]
                                            ? Container(
                                                width: double.infinity,
                                                margin: const EdgeInsets.only(
                                                  bottom: gap / 2,
                                                ),
                                                child: CardWithOutline(
                                                  context: context,
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  child: Center(
                                                    child: Text(
                                                      completeValues[
                                                                  completeStageStageCompletion] ==
                                                              maxLevel
                                                          ? 'Έχεις φτάσει στο τελευταίο Επίπεδο.'
                                                          : 'Συγχαρητήρια! Ανέβηκες Επίπεδο.',
                                                      style: TextStyle(
                                                        fontSize:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .fontSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        CardWithOutline(
                                          context: context,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              StatsHeader(context: context),
                                              ResultsContainer(
                                                context: context,
                                                stage: completeValues,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: gap,
                                  ),
                                  CompleteButtonsContainer(
                                    context: context,
                                    nextStage: () async {
                                      currentStage = await getCurrentStageMap();

                                      onStageButtonPressed(null);
                                    },
                                    backToHome: () {
                                      context.goNamed(
                                        PAGES.home.screenName,
                                        extra:
                                            completeValues[completeStageUser],
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
