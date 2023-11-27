import 'package:flutter/material.dart';

import '../../../../core/usecases/calculate_size.dart';

Widget CardText({
  required BuildContext context,
  required String text,
  required Color color,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: calculateSize(
        context,
        Theme.of(context).textTheme.bodyLarge!.fontSize!,
      ),
      fontWeight: FontWeight.bold,
    ),
    overflow: TextOverflow.ellipsis,
  );
}
