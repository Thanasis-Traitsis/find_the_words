import 'package:find_the_words/core/constants/styles.dart';
import 'package:find_the_words/features/stage/domain/usecases/game_usecases/answer_repositories.dart';
import 'package:find_the_words/features/stage/presentation/answer_bloc/answer_bloc.dart';
import 'package:flutter/material.dart';

import 'package:find_the_words/features/stage/presentation/widgets/shuffle_answer_hint_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/circle_positions.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/usecases/calculate_size.dart';
import '../../domain/usecases/game_usecases/extra_words_repositories.dart';
import '../../domain/usecases/game_usecases/shuffle_letters.dart';
import '../letters_bloc/letters_bloc.dart';
import 'circle_container_with_letters/circle_container.dart';
import 'circle_container_with_letters/line_painter.dart';
import 'circle_container_with_letters/render_object_widget.dart';
import 'game_buttons/extra_word_button.dart';

class ButtonsWithCircleLettersSection extends StatefulWidget {
  String answer;
  String letters;
  final Map stageMap;
  Map answeredPositions;

  ButtonsWithCircleLettersSection({
    Key? key,
    required this.answer,
    required this.letters,
    required this.stageMap,
    required this.answeredPositions,
  }) : super(key: key);

  @override
  State<ButtonsWithCircleLettersSection> createState() =>
      _ButtonsWithCircleLettersSectionState();
}

class _ButtonsWithCircleLettersSectionState
    extends State<ButtonsWithCircleLettersSection> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Column(
        children: [
          ShuffleAnswerHintContainer(
            letters: widget.letters,
            answer: widget.answer,
            // THIS FUNCTION IS FOR SHUFFLING THE LETTERS INSIDE THE CIRCLE
            shuffleFunction: () async {
              String mixedLetters = await shuffleLetters(
                letters: widget.letters,
              );

              setState(() {
                widget.letters = mixedLetters;
              });

              BlocProvider.of<LettersBloc>(context)
                  .add(SetLetters(letters: mixedLetters));

              positionLettersCircle(widget.letters);
            },
            // THIS FUNCTION RUNS WHEN WE FIND A CORRECT ANSWER
            addWord: (positions, word) {
              
              setState(() {
                if (positions.length > 1) {
                  widget.answeredPositions[answeredPositions].add(positions);
                  widget.answeredPositions[answeredWords].add(word);
                }

                for (var i = 0; i < positions.length; i++) {
                  if (!widget.answeredPositions[unavailablePositions]
                      .contains(positions[i])) {
                    widget.answeredPositions[unavailablePositions]
                        .add(positions[i]);
                  }
                }
              });

              saveAnswerWord(
                ansPos: widget.answeredPositions[answeredPositions],
                ansWord: widget.answeredPositions[answeredWords],
                unavaPos: widget.answeredPositions[unavailablePositions],
              );
            },
            // THIS FUNCTION RUNS WHEN WE TAP THE HINT BUTTON
            hintFunction: () {
              BlocProvider.of<AnswerBloc>(context).add(
                HintCalled(
                  stageMap: widget.stageMap,
                  answeredPositions: widget.answeredPositions,
                ),
              );
            },
            // THIS FUNCTION RUNS WHEN WE FIND AN EXTRA WORD
            callAnimation: (extraWord) async {
              await addExtraWordRepository(extraWord);

              togglePositionedAnimation();
            },
          ),
          const SizedBox(
            height: gap / 2,
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
              SizedBox(
                width: calculateSize(context, AppValuesMain().gameButton),
                height: calculateSize(context, AppValuesMain().gameButton),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
