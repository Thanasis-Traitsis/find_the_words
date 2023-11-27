  import 'dart:math';

Future<String> shuffleLetters({
    required String letters,
  }) async {
    var beforeChange = letters;
    List<String> characters = letters.split('');
    var random = Random();

    while (letters == beforeChange) {
      for (var i = characters.length - 1; i > 0; i--) {
        var j = random.nextInt(i + 1);
        var temp = characters[i];
        characters[i] = characters[j];
        characters[j] = temp;
      }

      letters = characters.join('');
    }

    return letters;
  }