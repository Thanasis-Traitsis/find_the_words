// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LevelProgressIndicator extends StatefulWidget {
  final double endValue;

  const LevelProgressIndicator({
    Key? key,
    required this.endValue,
  }) : super(key: key);

  @override
  State<LevelProgressIndicator> createState() => _LevelProgressIndicatorState();
}

class _LevelProgressIndicatorState extends State<LevelProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.animateTo(widget.endValue);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
      color: Theme.of(context).colorScheme.outline,
      semanticsLabel: 'Πρόοδος',
    );
  }
}
