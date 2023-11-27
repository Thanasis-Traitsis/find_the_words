import 'package:flutter/material.dart';

import '../../../../core/constants/sizes.dart';

Widget HomeBackground({
  required Widget child,
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
    child: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: child,
              ),
            ),
          );
        },
      ),
    ),
  );
}
