// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:find_the_words/core/constants/game_values.dart';
import 'package:find_the_words/core/constants/initial_values.dart';
import 'package:find_the_words/core/constants/styles.dart';
import 'package:find_the_words/features/auth/presentation/points_bloc/points_bloc.dart';
import 'package:find_the_words/features/stage/domain/usecases/game_usecases/answer_repositories.dart';
import 'package:find_the_words/features/stage/domain/usecases/game_usecases/clear_stage_after_completion.dart';
import 'package:find_the_words/features/stage/presentation/answer_bloc/answer_bloc.dart';
import 'package:find_the_words/features/stage/presentation/clickable_stage_bloc/clickable_stage_bloc.dart';
import 'package:find_the_words/features/stage/presentation/widgets/shuffle_answer_hint_container.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/circle_positions.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/usecases/calculate_size.dart';
import '../../../../core/utils/breakpoints_utils.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../../../../core/widgets/timer_stage_completion.dart';
import '../../../../current_stage.dart';
import '../../domain/usecases/game_usecases/all_words_repositories.dart';
import '../../domain/usecases/game_usecases/extra_words_repositories.dart';
import '../../domain/usecases/game_usecases/shuffle_letters.dart';
import '../letters_bloc/letters_bloc.dart';
import '../stage_scroll_bloc/stage_scroll_bloc.dart';
import '../stage_timer_bloc/stage_timer_bloc.dart';
import 'circle_container_with_letters/circle_container.dart';
import 'circle_container_with_letters/line_painter.dart';
import 'circle_container_with_letters/render_object_widget.dart';
import 'game_buttons/extra_word_button.dart';
import 'game_buttons/game_button.dart';
import 'game_buttons/hint_button_alert_dialog.dart';

class ButtonsWithCircleLettersSection extends StatefulWidget {
  String answer;
  String letters;
  final Map stageMap;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  Map answeredPositions;
  int timerValue;

  ButtonsWithCircleLettersSection({
    Key? key,
    required this.answer,
    required this.letters,
    required this.stageMap,
    required this.scaffoldMessengerKey,
    required this.answeredPositions,
    required this.timerValue,
  }) : super(key: key);

  @override
  State<ButtonsWithCircleLettersSection> createState() =>
      _ButtonsWithCircleLettersSectionState();
}

class _ButtonsWithCircleLettersSectionState
    extends State<ButtonsWithCircleLettersSection> {
  final player = AudioPlayer();

  late int counterTimer = widget.timerValue;

  // Pick the correct list of positions from the list circlePositions
  int? chosenList;
  // The lines that connect the letters inside the circle
  List<CustomPaint> lineConnections = [];
  // The list of the letters inside the circle
  List<Widget> stackLetters = [];
  // The starting position of the letter that the user taped
  Offset? startPosition;
  // The end position that changes every time the user moves his finger inside the circle
  Offset? endPosition;

  positionLettersCircle(String letters) {
    setState(() {
      for (var i = 0; i < circlePositions.length; i++) {
        if (circlePositions[i].length == letters.length) {
          chosenList = i;

          lineConnections = List<CustomPaint>.generate(
            letters.length - 1,
            (index) => CustomPaint(
              painter: LinePainter(
                startPosition: startPosition,
                endPosition: endPosition,
              ),
            ),
          );

          stackLetters = List<SingleChildRenderObjectWidget>.generate(
            letters.length,
            (index) {
              return ColorCircle(
                index: index,
                child: Align(
                  alignment: Alignment(
                    (circlePositions[i][index][0]).toDouble(),
                    (circlePositions[i][index][1]).toDouble(),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      letters[index],
                      style: TextStyle(
                        color: MainColors().white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }
    });
  }

  @override
  void initState() {
    positionLettersCircle(widget.letters);
    super.initState();
  }

  // ===================================================================================================================
  // THE ANIMATION FOR FINDING A NEW WORD

  double animationEnd = 0.0;

  void togglePositionedAnimation() async {
    await startToEnd();
  }

  Future<double> startToEnd() async {
    setState(() {
      animationEnd = calculateSize(context, AppValuesMain().gameButton) * 1.2;
    });
    return animationEnd;
  }

  // ===================================================================================================================
  // BUTTONS FUNCTIONS
  void shuffleButtonPress() async {
    String mixedLetters = await shuffleLetters(
      letters: widget.letters,
    );

    setState(() {
      widget.letters = mixedLetters;
    });

    BlocProvider.of<LettersBloc>(context)
        .add(SetLetters(letters: mixedLetters));

    positionLettersCircle(widget.letters);
  }

  void correctAnswer(List positions, String word) {
    setState(() {
      if (positions.length > 1) {
        widget.answeredPositions[answeredPositions].add(positions);
        widget.answeredPositions[answeredWords].add(word);

        addAllWordsRepository(word);
      }

      for (var i = 0; i < positions.length; i++) {
        if (!widget.answeredPositions[unavailablePositions]
            .contains(positions[i])) {
          widget.answeredPositions[unavailablePositions].add(positions[i]);
        }
      }
    });

    saveAnswerWord(
      ansPos: widget.answeredPositions[answeredPositions],
      ansWord: widget.answeredPositions[answeredWords],
      unavaPos: widget.answeredPositions[unavailablePositions],
    );

    if (widget.stageMap['wordPositions'].length ==
        widget.answeredPositions[answeredPositions].length) {
      BlocProvider.of<ClickableStageBloc>(context).add(
        const ChangeAbsorb(absorb: true),
      );

      Future.delayed(const Duration(seconds: 3), () {
        // This block will be executed after a delay of 3 seconds
        clearStageAfterCompletion(
          context: context,
          key: widget.answeredPositions['key'],
        );
      });
      player.play(AssetSource('sound/success.mp3'));
    } else {
      player.play(AssetSource('sound/correct.mp3'));
    }
  }

  void hintButtonPress() async {
    bool useHint = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return HintButtonAlertDialog(context: context);
      },
    );

    if (useHint) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      int? points = prefs.getInt(userPoints);

      points ??= 0;

      if (points >= hintCost) {
        Future.delayed(const Duration(milliseconds: 300), () {
          BlocProvider.of<AnswerBloc>(context).add(
            HintCalled(
              stageMap: widget.stageMap,
              answeredPositions: widget.answeredPositions,
            ),
          );

          BlocProvider.of<PointsBloc>(context).add(
            const ChangePoints(
              points: hintCost,
              isMinus: true,
            ),
          );
        });
      } else {
        widget.scaffoldMessengerKey.currentState?.showSnackBar(
          ScaffoldMessage(
            context: context,
            message:
                'Δεν έχετε αρκετούς πόντους για να χρησιμοποιήσετε τη βοήθεια.',
            onTap: () {
              BlocProvider.of<ClickableStageBloc>(context)
                  .add(const ChangeAbsorb(absorb: false));
              widget.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
            },
          ),
        );
      }
    }
  }

  void callAnimationForExtraWord(String extraWord) async {
    await addExtraWordRepository(extraWord);

    togglePositionedAnimation();

    addAllWordsRepository(extraWord);

    BlocProvider.of<PointsBloc>(context).add(
      ChangePoints(
        points: calculateExtraWordPoints(extraWord),
        isMinus: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = getDeviceOrientation(context);
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: deviceOrientation == DeviceOrientation.portrait
          ? Column(
              children: [
                ShuffleAnswerHintContainer(
                  isPortrait: deviceOrientation == DeviceOrientation.portrait,
                  letters: widget.letters,
                  answer: widget.answer,
                  shuffleFunction: () {
                    shuffleButtonPress();
                  },
                  addWord: (positions, word) {
                    correctAnswer(positions, word);
                  },
                  hintFunction: () {
                    hintButtonPress();
                  },
                  callAnimation: (extraWord) async {
                    callAnimationForExtraWord(extraWord);
                  },
                ),
                const SizedBox(
                  height: gap,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ExtraWordButton(
                      context: context,
                      endOfAnimation: animationEnd,
                      onEnd: () {
                        setState(() {
                          animationEnd = 0.0;
                        });
                      },
                    ),
                    CircleContainer(
                      letters: widget.letters,
                      stageMap: widget.stageMap,
                      answeredPositions: widget.answeredPositions,
                      answer: widget.answer,
                      //
                      chosenList: chosenList,
                      lineConnections: lineConnections,
                      stackLetters: stackLetters,
                      startPosition: startPosition,
                      endPosition: endPosition,
                      //
                      positionLettersFunction: (letters) {
                        positionLettersCircle(widget.letters);
                      },
                    ),
                    deviceOrientation == DeviceOrientation.portrait
                        ? SizedBox(
                            width: calculateSize(
                                context, AppValuesMain().gameButton),
                            height: calculateSize(
                                context, AppValuesMain().gameButton),
                          )
                        : Container(),
                  ],
                ),
                BlocBuilder<StageTimerBloc, StageTimerState>(
                  builder: (context, state) {
                    counterTimer = state.timerValue;

                    return TimerStageCompletion(
                      timerValue: widget.timerValue,
                      onTimerValueChanged: (value) {
                        var stageBox = Hive.box<CurrentStage>(currentStageBox);

                        var stage = stageBox.get(currentStageBox);
                        if (stage != null) {
                          stageBox.put(
                            currentStageBox,
                            CurrentStage(
                              answeredPositions: stage.answeredPositions,
                              answeredWords: stage.answeredWords,
                              unavailablePositions: stage.unavailablePositions,
                              key: stage.key,
                              allStageWords: stage.allStageWords,
                              tableList: stage.tableList,
                              wordPositions: stage.wordPositions,
                              timerOfStage: value,
                            ),
                          );
                        }

                        // Do something with the updated timer value, if needed
                        // For example, you can update a variable in the state.
                        BlocProvider.of<StageTimerBloc>(context)
                            .add(GetTimerValue(timer: value));
                      },
                    );
                  },
                ),
              ],
            )
          : Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GameButton(
                          isLandScape: true,
                          function: () {
                            shuffleButtonPress();
                          },
                          context: context,
                          icon: FontAwesomeIcons.shuffle,
                        ),
                        const SizedBox(
                          height: gap,
                        ),
                        GameButton(
                          isLandScape: true,
                          function: () {
                            hintButtonPress();
                          },
                          context: context,
                          icon: FontAwesomeIcons.lightbulb,
                        ),
                      ],
                    ),
                    ExtraWordButton(
                      isLandScape: true,
                      context: context,
                      endOfAnimation: animationEnd,
                      onEnd: () {
                        setState(() {
                          animationEnd = 0.0;
                        });
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<StageScrollBloc, StageScrollState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        physics: state.scrollable
                            ? const ScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ShuffleAnswerHintContainer(
                              isPortrait: deviceOrientation ==
                                  DeviceOrientation.portrait,
                              letters: widget.letters,
                              answer: widget.answer,
                              shuffleFunction: () {
                                shuffleButtonPress();
                              },
                              addWord: (positions, word) {
                                correctAnswer(positions, word);
                              },
                              hintFunction: () {
                                hintButtonPress();
                              },
                              callAnimation: (extraWord) async {
                                callAnimationForExtraWord(extraWord);
                              },
                            ),
                            const SizedBox(
                              height: gap / 2,
                            ),
                            CircleContainer(
                              letters: widget.letters,
                              stageMap: widget.stageMap,
                              answeredPositions: widget.answeredPositions,
                              answer: widget.answer,
                              //
                              chosenList: chosenList,
                              lineConnections: lineConnections,
                              stackLetters: stackLetters,
                              startPosition: startPosition,
                              endPosition: endPosition,
                              //
                              positionLettersFunction: (letters) {
                                positionLettersCircle(widget.letters);
                              },
                            ),
                            BlocBuilder<StageTimerBloc, StageTimerState>(
                              builder: (context, state) {
                                counterTimer = state.timerValue;

                                return TimerStageCompletion(
                                  timerValue: widget.timerValue,
                                  onTimerValueChanged: (value) {
                                    var stageBox =
                                        Hive.box<CurrentStage>(currentStageBox);

                                    var stage = stageBox.get(currentStageBox);
                                    if (stage != null) {
                                      stageBox.put(
                                        currentStageBox,
                                        CurrentStage(
                                          answeredPositions:
                                              stage.answeredPositions,
                                          answeredWords: stage.answeredWords,
                                          unavailablePositions:
                                              stage.unavailablePositions,
                                          key: stage.key,
                                          allStageWords: stage.allStageWords,
                                          tableList: stage.tableList,
                                          wordPositions: stage.wordPositions,
                                          timerOfStage: value,
                                        ),
                                      );
                                    }

                                    // Do something with the updated timer value, if needed
                                    // For example, you can update a variable in the state.
                                    BlocProvider.of<StageTimerBloc>(context)
                                        .add(GetTimerValue(timer: value));
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
