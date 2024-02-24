import 'package:flutter/material.dart';

import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_size.dart';
import 'blue_home_card.dart';
import 'earn_points_card.dart';
import 'green_home_card.dart';
import 'pink_home_card.dart';

Widget HomeCardsContainer({
  required BuildContext context,
  required String level,
}) {
  return Column(
    children: [
      const SizedBox(
        height: gap / 2,
      ),
      SizedBox(
        height: calculateSize(context, homeCardsContainer),
        child: Row(
          children: [
            PinkHomeCard(
              context: context,
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
      // const SizedBox(
      //   height: gap / 2,
      // ),
      // EarnPointsCard(context: context),
    ],
  );
}
