double calculateSpaceBetweenBoxes(double number) {
  if (number < 4) {
    return 5;
  }
  if (number < 5) {
    return 3.5;
  }
  if (number < 7) {
    return 3.5;
  }
  if (number < 10) {
    return 2;
  }

  return 1.3;
}
