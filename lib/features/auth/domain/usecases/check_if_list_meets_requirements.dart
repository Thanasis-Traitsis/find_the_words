List? checkIfListMeetsRequirements({
  required Map req,
  required List list,
}) {
  print(
      '4. ======================================================================================================');
  print('CHECK FOR REQUIREMENTS STARTS HERE');

  // 1. Sort the list from the biggest to the smallest
  list.sort((a, b) => b.length.compareTo(a.length));

  // 2. Remove all the small words that doesn't meet the requirements
  print(
      "The word length of the smallest available word should be: ${req['smallWordsLength']}");

  list.removeWhere((word) => word.length < req['smallWordsLength']);

  // 3. Get the amount of the biggest words
  int maxLength = 0;
  int count = 0;

  list.forEach((word) {
    if (word.length > maxLength) {
      maxLength = word.length;
      count = 1;
    } else if (word.length == maxLength) {
      count++;
    }
  });

  print("Number of words with the maximum length ($maxLength): $count");
  print("The amount of Big Words Needed is: ${req['amountOfBigWords']}");

  if (count < req['amountOfBigWords']) return null;

  // 4. Get the list length
  int listLength = list.length;
  print("The list length of the stage is: $listLength");
  print("The required stage length is: ${req['minStageLength']}");

  if (listLength < req['minStageLength']) return null;

  return list;
}
