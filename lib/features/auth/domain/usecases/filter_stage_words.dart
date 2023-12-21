import 'dart:math';

List filterStageWords({
  required int maxLength,
  required int minBigWords,
  required List list,
}) {
  List finalList = [];
  List bigWords = [];

  // 1. First, make a list with all the big words
  // Find the length of the longest word in the original list
  int bigWordLength =
      list.fold(0, (max, word) => word.length > max ? word.length : max);

  // Add words from the original list to the empty list if their length is equal to the maxLength
  bigWords.addAll(list.where((word) => word.length == bigWordLength));

  // 2. Add to the final list the min big words needed from the bigWords list
  // Pick random words from the bigWords list
  do {
    int random = Random().nextInt(bigWords.length);

    finalList.add(bigWords[random]);

    bigWords.removeAt(random);
  } while (finalList.length < minBigWords);

  // 3. Add all the other words until you reach the max length
  while (finalList.length < maxLength) {
    int random = Random().nextInt(list.length);

    if (!finalList.contains(list[random])) {
      finalList.add(list[random]);
    }
  }

  return finalList;
}
