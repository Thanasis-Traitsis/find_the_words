import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';

Future addExtraWordRepository(String extraWord) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Try reading data from the 'items' key. If it doesn't exist, returns null.
  List<String>? extraWords = prefs.getStringList(extraWordsList);

  extraWords ??= [];

  if (extraWords.contains(extraWord)) {
    return false;
  } else {
    extraWords.add(extraWord);

    // Save an list of strings to 'items' key.
    await prefs.setStringList(extraWordsList, extraWords);

    return true;
  }
}

Future<List> getExtraWordsRepository() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Try reading data from the 'items' key. If it doesn't exist, returns null.
  List<String>? extraWords = prefs.getStringList(extraWordsList);

  extraWords ??= [];

  return extraWords;
}

Future clearExtraWord() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Save an list of strings to 'items' key.
  await prefs.setStringList(extraWordsList, []);
}

int calculateExtraWordPoints(String extraWord) {
  if (extraWord.length < 4) {
    return 1;
  }
  if (extraWord.length < 8) {
    return 2;
  }

  return 3;
}
