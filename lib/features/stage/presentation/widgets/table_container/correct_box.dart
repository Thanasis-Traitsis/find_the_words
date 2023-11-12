import 'package:flutter/material.dart';

import '../../../../../core/constants/styles.dart';

class CorrectBox extends StatelessWidget {
  final String text;

  const CorrectBox({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.blue,
      ),
      margin: const EdgeInsets.all(1),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}