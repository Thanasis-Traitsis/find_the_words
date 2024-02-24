import 'package:find_the_words/core/constants/styles.dart';
import 'package:find_the_words/core/usecases/calculate_size.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/widgets/card_with_outline.dart';

Widget MenuItem({
  required BuildContext context,
  required String text,
  required IconData? icon,
  required Function function,
  bool hasIcon = false,
}) {
  return GestureDetector(
    onTap: () => function(),
    child: Container(
      margin: const EdgeInsets.only(top: gap / 3),
      width: double.infinity,
      child: CardWithOutline(
        color: Theme.of(context).colorScheme.background,
        context: context,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: calculateSize(
                    context,
                    Theme.of(context).textTheme.bodyLarge!.fontSize!,
                  ),
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: hasIcon
                  ? Icon(
                      icon,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      size: calculateSize(context, 25),
                    )
                  : null,
            ),
          ],
        ),
      ),
    ),
  );
}
