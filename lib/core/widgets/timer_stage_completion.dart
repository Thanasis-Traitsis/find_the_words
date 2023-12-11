// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/stage/presentation/stage_timer_bloc/stage_timer_bloc.dart';

class TimerStageCompletion extends StatefulWidget {
  final int timerValue;
  final Function(int) onTimerValueChanged;

  TimerStageCompletion({
    Key? key,
    required this.timerValue,
    required this.onTimerValueChanged,
  }) : super(key: key);

  @override
  State<TimerStageCompletion> createState() => _TimerStageCompletionState();
}

class _TimerStageCompletionState extends State<TimerStageCompletion> {
  late int value = widget.timerValue;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Check if the widget is still mounted before updating the state
      if (mounted) {
        setState(() {
          value++;
          widget.onTimerValueChanged(value);
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
