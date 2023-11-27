// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_the_words/features/stage/presentation/scrollable_bloc/scrollable_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/circle_positions.dart';
import '../../answer_bloc/answer_bloc.dart';
import 'line_painter.dart';
import 'render_object_widget.dart';

class CircleContainer extends StatefulWidget {
  String letters;
  final Map stageMap;
  Map answeredPositions;
  String answer;
  final Function positionLettersFunction;

  int? chosenList;
  List<CustomPaint> lineConnections;
  List<Widget> stackLetters;
  Offset? startPosition;
  Offset? endPosition;

  CircleContainer({
    Key? key,
    required this.letters,
    required this.stageMap,
    required this.answeredPositions,
    required this.answer,
    required this.positionLettersFunction,
    required this.chosenList,
    required this.lineConnections,
    required this.stackLetters,
    required this.startPosition,
    required this.endPosition,
  }) : super(key: key);

  @override
  State<CircleContainer> createState() => _CircleContainerState();
}

class _CircleContainerState extends State<CircleContainer> {
  bool stageIsNotComplete = true;

  final key = GlobalKey();
  Set<int> selectedIndexes = <int>{};
  Set<ColorCircleProxy> trackTaped = <ColorCircleProxy>{};

  // Count the letters that the user taps on
  var count = 0;
  // All the starting positions (the letter positions)
  List<Offset?> startPositionList = [];
  // All the ending positions (the letter positions)
  List<Offset?> endPositionList = [];

  detectTapedItem(PointerEvent event, String letters) {
    BlocProvider.of<ScrollableBloc>(context)
        .add(const UpdateScrollableStageScreen(
      scrollable: false,
    ));

    final RenderBox box =
        key.currentContext!.findAncestorRenderObjectOfType<RenderBox>()!;
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);

    setState(() {
      widget.endPosition = local;

      if (count != 0 && count < letters.length) {
        widget.lineConnections[count - 1] = CustomPaint(
          painter: LinePainter(
            startPosition: startPositionList[count - 1],
            endPosition: widget.endPosition,
          ),
        );
      }
      if (count > 1 && count <= letters.length) {
        widget.lineConnections[count - 2] = CustomPaint(
          painter: LinePainter(
            startPosition: widget.startPosition,
            endPosition: startPositionList[count - 2],
          ),
        );
      }
    });

    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        final target = hit.target;
        if (target is ColorCircleProxy && !trackTaped.contains(target)) {
          var x = (circlePositions[widget.chosenList!][target.index][0] * 100 +
              100);
          var y = (circlePositions[widget.chosenList!][target.index][1] * 100 +
              100);

          // for Y
          if (y != 100) {
            if (x % 100 == 0) {
              y > 100 ? y -= 20 : y += 20;
            } else {
              y > 100 ? y -= 10 : y += 10;
            }
          }

          // for X
          if (x != 100) {
            if (y % 100 == 0) {
              x > 100 ? x -= 20 : x += 20;
            } else {
              x > 100 ? x -= 10 : x += 10;
            }
          }

          setState(() {
            widget.startPosition = Offset(
              (x).toDouble(),
              (y).toDouble(),
            );

            startPositionList.add(widget.startPosition);

            if (count < letters.length - 1) {
              widget.lineConnections[count] = CustomPaint(
                painter: LinePainter(
                  startPosition: widget.startPosition,
                  endPosition: widget.endPosition,
                ),
              );
            }
          });

          count++;

          trackTaped.add(target);
          selectIndex(target.index, letters);
        }
      }
    }
  }

  selectIndex(int index, String letters) {
    BlocProvider.of<AnswerBloc>(context).add(
      AnswerLetterHover(letter: letters[index]),
    );
    setState(() {
      selectedIndexes.add(index);

      widget.stackLetters[index] = ColorCircle(
        index: index,
        child: Align(
          alignment: Alignment(
            (circlePositions[widget.chosenList!][index][0]).toDouble(),
            (circlePositions[widget.chosenList!][index][1]).toDouble(),
          ),
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Text(
              letters[index],
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    });
  }

  // ============================================================ ANSWER
  // Function for clearing the answer
  clearAnswer() {
    setState(() {
      count = 0;
      widget.startPosition = null;
      widget.endPosition = null;
      startPositionList = [];
      endPositionList = [];
      selectedIndexes = <int>{};
      trackTaped = <ColorCircleProxy>{};
      widget.stackLetters = [];
      widget.positionLettersFunction(widget.letters);
      BlocProvider.of<ScrollableBloc>(context)
          .add(const UpdateScrollableStageScreen(
        scrollable: true,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (stageIsNotComplete) {
          detectTapedItem(
            event,
            widget.letters,
          );
        }
      },
      onPointerMove: (event) {
        if (stageIsNotComplete) {
          detectTapedItem(
            event,
            widget.letters,
          );
        }
      },
      onPointerUp: (event) {
        BlocProvider.of<AnswerBloc>(context).add(
          AnswerCompleted(
            stageMap: widget.stageMap,
            answeredPositions: widget.answeredPositions,
          ),
        );
        clearAnswer();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        width: 200,
        height: 200,
        child: Stack(
          children: [
            ...widget.lineConnections,
            Stack(
              key: key,
              children: widget.stackLetters,
            ),
          ],
        ),
      ),
    );
  }
}
