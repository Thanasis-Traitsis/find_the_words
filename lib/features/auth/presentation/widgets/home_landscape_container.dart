import 'package:flutter/material.dart';

Widget HomeLandscapeContainer({
  required Widget child,
}) {
  return Expanded(
    child: Container(
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
