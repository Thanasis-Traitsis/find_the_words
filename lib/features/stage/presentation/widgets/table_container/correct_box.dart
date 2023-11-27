// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:find_the_words/config/theme/colors.dart';
import 'package:find_the_words/core/usecases/calculate_size.dart';

import '../../../../../core/constants/styles.dart';
import '../../../domain/usecases/creating_stage/calculate_space_between_boxes.dart';

class CorrectBox extends StatefulWidget {
  final String text;
  final double tableRowLength;
  Color color;
  bool isCorrect;
  double? scale;
  int? delay;
  double? margin;

  CorrectBox({
    Key? key,
    required this.text,
    required this.tableRowLength,
    required this.color,
    this.isCorrect = false,
    this.scale,
    this.delay,
    this.margin,
  }) : super(key: key);

  @override
  State<CorrectBox> createState() => _CorrectBoxState();
}

class _CorrectBoxState extends State<CorrectBox> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(boxBorderRadius),
        color: Theme.of(context).colorScheme.outline,
      ),
      margin: EdgeInsets.all(
        calculateSize(
          context,
          calculateSpaceBetweenBoxes(widget.tableRowLength),
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(boxBorderRadius),
          color: widget.color,
          border: Border.all(
            color: widget.isCorrect
                ? Theme.of(context).colorScheme.outline
                : Theme.of(context).colorScheme.outline.withOpacity(.5),
            width: 1,
          ),
        ),
        margin: widget.isCorrect
            ? EdgeInsets.only(
                top: widget.margin!,
                left: widget.margin!,
                right: widget.margin! * 2,
                bottom: widget.margin! * 2,
              )
            : const EdgeInsets.all(0),
        onEnd: () {
          Future.delayed(
              Duration(
                  milliseconds: widget.delay != null ? widget.delay! * 100 : 0),
              () {
            setState(() {
              widget.color = Theme.of(context).colorScheme.primaryContainer;
              widget.scale = 1.0;
            });
          });
        },
        alignment: FractionalOffset.center,
        transform: Matrix4.diagonal3Values(
          widget.scale ?? 1.0,
          widget.scale ?? 1.0,
          1.0,
        ),
        curve: Curves.easeOutBack,
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: calculateSize(
                context,
                30 - widget.tableRowLength,
              ),
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
