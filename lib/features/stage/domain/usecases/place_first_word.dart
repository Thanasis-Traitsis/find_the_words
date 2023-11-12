List placeFirstWord({
  required String word,
  required int center,
  required List<String> tbList,
  bool isHosizontal = true,
}) {
  List position = [];

  if (isHosizontal) {
    for (var i = 0; i < word.length; i++) {
      tbList[(center + i)] = word[i];
      position.add(center + i);
    }
  }

  return position;
}
