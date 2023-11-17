import 'package:flutter/material.dart';

import '../../../presentation/widgets/table_container/table_box.dart';


List<Widget> generateWidgetTable(int length) {
  return List<Widget>.generate(
    length,
    (index) => TableBox(text: index.toString()),
  );
}
