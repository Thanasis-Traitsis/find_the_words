import 'is_empty_box.dart';

int countAvailableColumns({
  required int startOfSearch,
  required int endOfSearch,
  required int tableRowsAndColumns,
  required List<String> tableList,
}) {
  int counter = 0;

  for (var i = startOfSearch; i < endOfSearch; i++) {
    List count = [];
    for (var j = 0; j < tableList.length; j += tableRowsAndColumns) {
      if (isEmptyBox(tableList[i + j])) count.add([i + j]);
      if (count.length == tableRowsAndColumns) {
        counter++;
      }
    }
  }

  return counter;
}