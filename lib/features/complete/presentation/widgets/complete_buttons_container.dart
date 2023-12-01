import 'package:flutter/material.dart';

import '../../../../core/usecases/calculate_size.dart';

Widget CompleteButtonsContainer({
  required BuildContext context,
  required Function nextStage,
  required Function backToHome,
}) {
  return Column(
    children: [
      FilledButton(
        onPressed: () => nextStage(),
        child: Text(
          'Επόμενο Στάδιο',
          style: TextStyle(
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyLarge!.fontSize!,
            ),
          ),
        ),
      ),
      TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.outline,
          ),
        ),
        onPressed: () => backToHome(),
        child: Text(
          'Πίσω στην αρχική',
          style: TextStyle(
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyMedium!.fontSize!,
            ),
          ),
        ),
      ),
    ],
  );
}
