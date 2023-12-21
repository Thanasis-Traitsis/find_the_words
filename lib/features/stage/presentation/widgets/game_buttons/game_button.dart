import 'package:flutter/material.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/usecases/calculate_size.dart';

Widget GameButton({
  required BuildContext context,
  required IconData icon,
  required Function function,
  bool isLandScape = false,
  bool isBox = false,
}) {
  return SizedBox(
    width: calculateSize(
        context,
        isLandScape
            ? AppValuesMain().gameButton - 10
            : AppValuesMain().gameButton),
    height: calculateSize(
        context,
        isLandScape
            ? AppValuesMain().gameButton - 10
            : AppValuesMain().gameButton),
    child: FilledButton(
      onPressed: () {
        function();
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: isBox ? 5.0 : 0),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.surface,
          size: calculateSize(
            context,
            isLandScape
                ? Theme.of(context).primaryIconTheme.size! * .6
                : Theme.of(context).primaryIconTheme.size! * .7,
          ),
        ),
      ),
    ),
  );
}
