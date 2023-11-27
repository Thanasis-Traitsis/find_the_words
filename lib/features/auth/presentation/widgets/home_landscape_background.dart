import 'package:flutter/material.dart';

import '../../../../core/constants/sizes.dart';

Widget HomeLandscapeBackground({
  required List<Widget> children,
}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/background-image.png"),
        opacity: .8,
        alignment: Alignment.bottomCenter,
        fit: BoxFit.fitWidth,
      ),
    ),
    padding: EdgeInsets.all(AppValuesMain().padding),
    width: double.infinity,
    height: double.infinity,
    child: SafeArea(
      child: Row(
        children: children,
      ),
    ),
  );
}
