List getCommonPositions(List wordPositions) {
  // Extract all positions into a single list
  List allPositions = wordPositions.expand((list) => list).toList();

  // Create a list of common positions (positions that appear more than once)
  List commonPositions = [];
  Set seenPositions = Set();

  for (int position in allPositions) {
    if (!seenPositions.add(position)) {
      // The position is already in the set, meaning it's a common position
      commonPositions.add(position);
    }
  }

  print('Common Positions: $commonPositions');
  return commonPositions;
}
