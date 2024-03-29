// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/usecases/calculate_size.dart';
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
  final Function(String extra) callAnimation;
  bool isPortrait;

  ShuffleAnswerHintContainer({
    Key? key,
    required this.letters,
    required this.answer,
    required this.shuffleFunction,
    required this.addWord,
    required this.hintFunction,
    required this.callAnimation,
    this.isPortrait = true,
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
        widget.isPortrait
            ? GameButton(
                function: () {
                  widget.shuffleFunction();
                },
                context: context,
                icon: FontAwesomeIcons.shuffle,
              )
            : SizedBox(
                height: calculateSize(context, AppValuesMain().gameButton),
              ),
        BlocConsumer<AnswerBloc, AnswerState>(
          listener: (context, state) {
            if (state is AnswerCorrect) {
              widget.addWord(state.positions, state.word);
            }
            if (state is AnswerIsExtraWord) {
              widget.callAnimation(state.word);
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
        widget.isPortrait
            ? GameButton(
                function: () {
                  widget.hintFunction();
                },
                context: context,
                icon: FontAwesomeIcons.lightbulb,
              )
            : Container(),
      ],
    );
  }
}
