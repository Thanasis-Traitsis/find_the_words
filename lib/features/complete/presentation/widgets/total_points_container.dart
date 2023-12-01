import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';
import '../../../../core/widgets/card_with_outline.dart';

Widget TotalPoints({
  required BuildContext context,
  required int sum,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Συνολικοί Πόντοι:',
        style: TextStyle(
          fontSize: calculateSize(
            context,
            Theme.of(context).textTheme.bodyLarge!.fontSize!,
          ),
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
      CardWithOutline(
        context: context,
        color: Theme.of(context).canvasColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$sum',
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
              width: gap / 4,
            ),
            Icon(
              FontAwesomeIcons.solidStar,
              size: calculateSize(
                context,
                Theme.of(context).iconTheme.size! - 5,
              ),
              color: Theme.of(context).colorScheme.outline,
            )
          ],
        ),
      ),
    ],
  );
}
