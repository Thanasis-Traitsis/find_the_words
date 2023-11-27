import 'package:flutter/material.dart';

import '../../../../../core/usecases/calculate_size.dart';

Widget TitleOfAppbar({
  required BuildContext context,
  required String stage,
}) {
  return Text(
    'Στάδιο $stage',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: calculateSize(
        context,
        Theme.of(context).textTheme.bodyLarge!.fontSize!,
      ),
    ),
  );
}
