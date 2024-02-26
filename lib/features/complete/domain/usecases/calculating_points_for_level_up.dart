int calculatingPointsForLevelUp(int lvl) {
  switch (lvl) {
    case 1:
      return 10;
    case 2:
      return 15;
    case 3:
      return 20;
    case 4:
      return 30;
    case 5:
      return 40;
    case 6:
      return 55;
    default:
      return 70;
  }
}
