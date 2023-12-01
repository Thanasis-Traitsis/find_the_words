import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';

Widget TextWithResult({
  required BuildContext context,
  required String header,
  required int stat,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          '$header:',
          style: TextStyle(
            fontSize: calculateSize(
              context,
              Theme.of(context).textTheme.bodyMedium!.fontSize!,
            ),
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: gap / 2,
          ),
          Text(
            '+ $stat',
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
              Theme.of(context).iconTheme.size! - 10,
            ),
            color: Theme.of(context).colorScheme.outline,
          )
        ],
      ),
    ],
  );
}
