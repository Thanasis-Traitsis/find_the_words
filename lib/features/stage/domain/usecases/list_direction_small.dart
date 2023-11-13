import 'is_empty_box.dart';

List listDirectionSmall({
  required int rowLength,
  required List tableDirections,
  required List<String> tableList,
  required int dir,
}) {
  int counter = 0;
  if (dir == 0) {
    for (var i = 0; i < rowLength; i++) {
      if (isEmptyBox(tableList[i])) {
        counter += 1;
      } else {
        counter = 0;
      }
    }
  }
  if (dir == 1) {
    for (var i = 0; i < rowLength; i++) {
      if (isEmptyBox(tableList[(rowLength - 1) + (rowLength * i)])) {
        counter += 1;
      } else {
        counter = 0;
      }
    }
  }
  if (dir == 2) {
    for (var i = 0; i < rowLength; i++) {
      if (isEmptyBox(tableList[(tableList.length - 1) - i])) {
        counter += 1;
      } else {
        counter = 0;
      }
    }
  }
  if (dir == 3) {
    for (var i = 0; i < rowLength; i++) {
      if (isEmptyBox(tableList[rowLength * i])) {
        counter += 1;
      } else {
        counter = 0;
      }
    }
  }

  if (counter == rowLength) {
    tableDirections[dir] = 1;
  }

  return tableDirections;
}
