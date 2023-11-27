double calculateMargin(int tableLengthRow) {
  if (tableLengthRow < 4) {
    return 2;
  }
  if (tableLengthRow < 5) {
    return 1.7;
  }
  if (tableLengthRow < 7) {
    return 1.5;
  }
  if (tableLengthRow < 10) {
    return 1;
  }
  if (tableLengthRow < 12) {
    return .8;
  }

  return .5;
}
