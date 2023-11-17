import 'package:flutter/material.dart';

import 'apply_changes.dart';
import 'generate_table_list.dart';
import 'generate_widget_table.dart';

Future<List> makeTableSmallerByTwo({
  required int rowLength,
  required List<String> tableList,
  required List wordPositions,
  required List<Widget> widgetList,
}) async {
  var oldRowLength = rowLength;
  rowLength = rowLength - 2;

  var newBoxes = rowLength * rowLength;

  var newTbList = generateTableList(newBoxes);
  var newWidgetList = generateWidgetTable(newBoxes);

  var count = 0;

  for (var i = 1; i <= rowLength; i++) {
    for (var j = 1; j <= rowLength; j++) {
      newTbList[count] = tableList[j + (i * oldRowLength)];
      count++;
    }
  }

  for (var i = 0; i < wordPositions.length; i++) {
    for (var j = 0; j < wordPositions[i].length; j++) {
      wordPositions[i][j] -= (oldRowLength +
          1 +
          (2 * ((wordPositions[i][j] ~/ oldRowLength) - 1)));
    }
  }

  widgetList = await applyChanges(
    positions: wordPositions,
    tbList: newTbList,
    wdtList: newWidgetList,
  );

  tableList = newTbList;

  return [widgetList, tableList];
}
