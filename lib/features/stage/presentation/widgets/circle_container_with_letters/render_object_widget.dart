import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColorCircle extends SingleChildRenderObjectWidget {
  final int index;

  ColorCircle({required Widget child, required this.index, Key? key})
      : super(child: child, key: key);

  @override
  ColorCircleProxy createRenderObject(BuildContext context) {
    return ColorCircleProxy(index);
  }

  @override
  void updateRenderObject(BuildContext context, ColorCircleProxy renderObject) {
    renderObject..index = index;
  }
}

class ColorCircleProxy extends RenderProxyBox {
  int index;
  ColorCircleProxy(this.index);
}
