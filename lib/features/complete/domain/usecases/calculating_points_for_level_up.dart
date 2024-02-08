int calculatingPointsForLevelUp(int lvl) {
  switch (lvl) {
    case 1:
      return 10;
    case 2:
      return 15;
    case 3:
      return 20;
    case 4:
      return 40;
    case 5:
      return 55;
    case 6:
      return 70;
    default:
      return 85;
  }
}
