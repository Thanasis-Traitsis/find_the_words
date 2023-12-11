import 'package:find_the_words/core/usecases/calculate_size.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/theme/colors.dart';

SnackBar ScaffoldMessage({
  required String message,
  required onTap,
  required BuildContext context,
  bool noError = true,
}) {
  return SnackBar(
    backgroundColor: noError
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: calculateSize(
                context,
                Theme.of(context).textTheme.bodyMedium!.fontSize!,
              ),
            ),
          ),
        ),
        noError
            ? InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.surface,
                ),
              )
            : Icon(
                Icons.signal_wifi_connected_no_internet_4_rounded,
                color: Theme.of(context).colorScheme.surface,
              ),
      ],
    ),
    elevation: 5,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    duration: noError ? const Duration(seconds: 3) : const Duration(days: 1),
  );
}
