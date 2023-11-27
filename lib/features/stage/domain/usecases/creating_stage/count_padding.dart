double countPadding(int number) {
  if (number < 4) {
    return 25;
  }
  if (number < 5) {
    return 20;
  }
  if (number < 7) {
    return 15;
  }
  if (number < 10) {
    return 10;
  }
  if (number < 12) {
    return 5;
  }

  return 0;
}
