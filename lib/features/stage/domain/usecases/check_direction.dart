bool checkDirection(List previousWordPosition) {
  int count = 0;

  for (var i = 1; i < previousWordPosition.length; i++) {
    if (previousWordPosition[i] - previousWordPosition[i - 1] == 1) {
      count++;
    }
  }

  return (count == previousWordPosition.length - 1);
}
