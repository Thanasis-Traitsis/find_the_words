import 'package:find_the_words/features/stage/presentation/widgets/table_container/available_neighbor.dart';
import 'package:find_the_words/features/stage/presentation/widgets/table_container/correct_box.dart';
import 'package:flutter/material.dart';

import '../../presentation/widgets/table_container/unavailable_neighbor.dart';

Future<List<Widget>> applyChanges({
  required List positions,
  required List<String> tbList,
  required List<Widget> wdtList,
}) async {
  for (var i = 0; i < tbList.length; i++) {
    if (tbList[i] == 'X') {
      // wdtList[i] = AvailableNeighbor(text: i.toString());
    } else if (tbList[i] == 'XX') {
      // wdtList[i] = UnavailableNeighbor(text: i.toString());
    } else if (positions.any((sublist) => sublist.contains(i))) {
      wdtList[i] = CorrectBox(text: tbList[i]);
    }
  }

  return wdtList;
}
