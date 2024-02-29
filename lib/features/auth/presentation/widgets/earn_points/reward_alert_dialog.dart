import 'package:flutter/material.dart';

import '../../../../../core/constants/game_values.dart';
import '../../../../../core/usecases/calculate_size.dart';

AlertDialog RewardAlertDialog({
  required BuildContext context,
}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      side: BorderSide(
        width: 4,
        color: Theme.of(context).colorScheme.outline,
      ),
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
    title: Text(
      'Συγχαρητήρια!',
      style: TextStyle(
        color: Theme.of(context).colorScheme.surface,
        fontWeight: FontWeight.bold,
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.headlineLarge!.fontSize!,
        ),
      ),
    ),
    content: Text(
      'Μόλις κέρδισες $earnPoints πόντους! Θα προστεθούν στο λογαριασμό σου αμέσως, για να σε βοηθήσουν στο επόμενο στάδιο.',
      style: TextStyle(
        color: Theme.of(context).colorScheme.surface,
        fontSize: calculateSize(
          context,
          Theme.of(context).textTheme.bodyLarge!.fontSize!,
        ),
      ),
    ),
  );
}
