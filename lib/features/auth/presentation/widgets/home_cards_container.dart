import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';
import 'blue_home_card.dart';
import 'green_home_card.dart';
import 'pink_home_card.dart';

Widget HomeCardsContainer({
  required BuildContext context,
  required String points,
  required String level,
}) {
  return Column(
    children: [
      SizedBox(
        height: calculateSize(context, homeCardsContainer),
        child: Row(
          children: [
            PinkHomeCard(
              context: context,
              points: points,
            ),
            const SizedBox(
              width: gap / 2,
            ),
            BlueHomeCard(),
          ],
        ),
      ),
      const SizedBox(
        height: gap / 2,
      ),
      GreenHomeCard(
        context: context,
        level: level,
      ),
    ],
  );
}
