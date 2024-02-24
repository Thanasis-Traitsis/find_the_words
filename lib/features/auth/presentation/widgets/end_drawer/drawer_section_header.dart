import 'package:flutter/material.dart';

import '../../../../../core/usecases/calculate_size.dart';

Widget DrawerSectionHeader({
  required BuildContext context,
  required String text,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: calculateSize(
        context,
        Theme.of(context).textTheme.bodyLarge!.fontSize!,
      ),
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.outline,
    ),
  );
}
