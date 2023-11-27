// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../answer_bloc/answer_bloc.dart';
import 'answer_container.dart';
import 'game_buttons/game_button.dart';

class ShuffleAnswerHintContainer extends StatefulWidget {
  String letters;
  String answer;
  final Function shuffleFunction;
  final Function(
    List positions,
    String word,
  ) addWord;
  final Function hintFunction;

  ShuffleAnswerHintContainer({
    Key? key,
    required this.letters,
    required this.answer,
    required this.shuffleFunction,
    required this.addWord,
    required this.hintFunction,
  }) : super(key: key);

  @override
  State<ShuffleAnswerHintContainer> createState() =>
      _ShuffleAnswerHintContainerState();
}

class _ShuffleAnswerHintContainerState
    extends State<ShuffleAnswerHintContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GameButton(
          function: () {
            widget.shuffleFunction();
          },
          context: context,
          icon: FontAwesomeIcons.shuffle,
        ),
        BlocConsumer<AnswerBloc, AnswerState>(
          listener: (context, state) {
            if (state is AnswerCorrect) {
              widget.addWord(state.positions, state.word);
            }
          },
          builder: (context, state) {
            if (state is AnswerComplete) {
              widget.answer = state.answer;
            }
            if (state is AnswerCorrect) {
              widget.answer = '';
            }
            return AnswerContainer(
              context: context,
              answer: widget.answer,
            );
          },
        ),
        GameButton(
          function: () {
            widget.hintFunction();
          },
          context: context,
          icon: FontAwesomeIcons.lightbulb,
        ),
      ],
    );
  }
}
