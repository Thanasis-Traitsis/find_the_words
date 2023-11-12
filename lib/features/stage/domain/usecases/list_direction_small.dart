import 'is_empty_box.dart';

List listDirectionSmall({
  required int rowLength,
  required List tableDirections,
  required List<String> tableList,
  required int dir,
}) {
  int counter = 0;

  for (var i = 0; i < rowLength; i++) {
    if (isEmptyBox(tableList[i])) {
      counter += 1;
    } else {
      counter = 0;
    }

    if (counter == rowLength) {
      tableDirections[dir] = 1;
    }
  }

  return tableDirections;
}
