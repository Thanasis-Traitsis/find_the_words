import 'package:flutter/material.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';

Widget SimpleIconButton({
  required BuildContext context,
  required Function function,
  required IconData icon,
}) {
  return GestureDetector(
    onTap: () => function(),
    child: Container(
      margin: EdgeInsets.only(
        right: AppValuesMain().padding,
        // top: AppValuesMain().padding,
      ),
      padding: EdgeInsets.all(
        calculateSize(
          context,
          padding - 2,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: calculateSize(
            context,
            2,
          ),
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Icon(
        icon,
        size: calculateSize(
          context,
          30,
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    ),
  );
}
