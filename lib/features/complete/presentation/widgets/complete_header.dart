import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';

Widget CompleteHeader({
  required BuildContext context,
  required int stage,
}) {
  return Column(
    children: [
      Text(
        'Το Στάδιο $stage ολοκληρώθηκε με επιτυχία!',
        style: TextStyle(
          fontSize: calculateSize(
            context,
            Theme.of(context).textTheme.headlineLarge!.fontSize!,
          ),
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.headlineLarge!.color,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: gap / 2,
      ),
    ],
  );
}
