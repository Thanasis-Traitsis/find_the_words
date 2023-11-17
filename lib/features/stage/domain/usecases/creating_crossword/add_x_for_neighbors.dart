String addXForNeighbor(String position) {
  if (position == '' || position == 'X') {
    return position += 'X';
  } else {
    return position;
  }
}
