import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/usecases/calculate_size.dart';
import '../simple_icon_button.dart';

Widget CustomDrawerHeader({
  required BuildContext context,
  required GlobalKey<ScaffoldState> key,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        'Μενού',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: calculateSize(
            context,
            Theme.of(context).textTheme.headlineLarge!.fontSize!,
          ),
        ),
      ),
      SimpleIconButton(
        context: context,
        function: () => key.currentState!.closeEndDrawer(),
        icon: FontAwesomeIcons.xmark,
      ),
    ],
  );
}
