import 'package:flutter/material.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/usecases/calculate_size.dart';

Widget LogoContainer({
  required BuildContext context,
}) {
  return SizedBox(
    width: calculateSize(
      context,
      AppValuesMain().logoSize,
    ),
    child: Image.asset(
      "assets/images/LOGO.png",
    ),
  );
}
