List findSmallerAndBiggerWord(List words) {
  // Initialize variables to store the smallest and largest word lengths
  int smallestLength = words[0].length;
  int largestLength = words[0].length;

  // Iterate through the list to find the smallest and largest lengths
  for (List word in words) {
    int length = word.length;

    // Update smallest length if current word is smaller
    if (length < smallestLength) {
      smallestLength = length;
    }

    // Update largest length if current word is larger
    if (length > largestLength) {
      largestLength = length;
    }
  }

  // Print the results
  print('Smallest word length: $smallestLength');
  print('Largest word length: $largestLength');
  return [smallestLength, largestLength];
}
