// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:find_the_words/core/usecases/calculate_size.dart';

import '../../../../../core/constants/game_values.dart';

class CountdownTimer extends StatefulWidget {
  final Duration timeRemaining;

  const CountdownTimer({
    Key? key,
    required this.timeRemaining,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration? countdownDuration;
  Duration duration = const Duration();
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    countdownDuration = const Duration(hours: earnPointsTimer) - widget.timeRemaining;
    startTimer();
    reset();
    super.initState();
  }

  void reset() {
    setState(() {
      duration = countdownDuration!;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => removeTime());
  }

  void removeTime() {
    const removeSeconds = 1;

    if (duration.inSeconds > 0) {
      setState(() {
        final seconds = duration.inSeconds - removeSeconds;

        duration = Duration(seconds: seconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildTime();
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text(
      '$hours : $minutes : $seconds',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: calculateSize(
          context,
          30,
        ),
      ),
    );
  }
}
