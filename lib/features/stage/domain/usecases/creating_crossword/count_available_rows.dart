import 'is_empty_box.dart';

int countAvailableRows({
  required int startOfSearch,
  required int endOfSearch,
  required int tableRowsAndColumns,
  required List<String> tableList,
}) {
  int counterAboveMiddle = 0;

  for (var i = startOfSearch; i < endOfSearch; i = i + tableRowsAndColumns) {
    List count = [];
    for (var j = 0; j < tableRowsAndColumns; j++) {
      if (isEmptyBox(tableList[i + j])) count.add([i + j]);
      if (count.length == tableRowsAndColumns) {
        counterAboveMiddle++;
      }
    }
  }

  return counterAboveMiddle;
}
