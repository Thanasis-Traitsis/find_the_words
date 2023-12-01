import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';

Widget StatsHeader({
  required BuildContext context,
}) {
  return Column(
    children: [
      Text(
        'Αποτελέσματα Σταδίου',
        style: TextStyle(
          fontSize: calculateSize(
            context,
            Theme.of(context).textTheme.bodyLarge!.fontSize!,
          ),
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
      const SizedBox(
        height: gap / 2,
      ),
    ],
  );
}
