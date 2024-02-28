import 'package:find_the_words/core/constants/styles.dart';
import 'package:find_the_words/features/auth/presentation/widgets/earn_points/countdown_timer.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/game_values.dart';
import '../../../../../core/usecases/calculate_size.dart';

AlertDialog TimerAlertDialog({
  required BuildContext context,
  required String timer,
}) {
  List<String> parts = timer.split(':');
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  double seconds = double.parse(parts[2]);

  Duration timerDuration = Duration(
    hours: hours.abs(),
    minutes: minutes.abs(),
    seconds: seconds.abs().toInt(),
  );

  return AlertDialog(
    title: Text(
      'Μήπως βιάζεσαι;',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.headlineLarge!.fontSize!,
        ),
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Δυστυχώς δεν μπορείς να κερδίσεις άπειρους πόντους. Το δώρο για την κάθε προβολή διαφήμισης, είναι διαθέσιμο κάθε $earnPointsTimer ώρες. Ο χρόνος που σου απομένει μέχρι το επόμενο δώρο είναι:',
          style: TextStyle(
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyLarge!.fontSize!,
            ),
          ),
        ),
        const SizedBox(
          height: gap,
        ),
        CountdownTimer(
          timeRemaining: timerDuration,
        ),
      ],
    ),
  );
}
