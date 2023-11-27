import 'package:flutter/material.dart';

import '../constants/styles.dart';
import '../usecases/calculate_size.dart';

Widget CardWithOutline({
  required BuildContext context,
  required Color color,
  required Widget child,
  bool hasColor = true,
}) {
  return Container(
    padding: EdgeInsets.only(
      right: calculateSize(
        context,
        3,
      ),
      bottom: calculateSize(
        context,
        3,
      ),
    ),
    decoration: BoxDecoration(
      color: hasColor ? Theme.of(context).colorScheme.outline : null,
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
    ),
    child: Container(
      padding: EdgeInsets.all(
        calculateSize(
          context,
          padding,
        ),
      ),
      decoration: BoxDecoration(
        color: hasColor ? color : null,
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
      child: child,
    ),
  );
}
