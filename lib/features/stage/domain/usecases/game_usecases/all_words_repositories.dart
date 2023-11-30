import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';

Future addAllWordsRepository(String newWord) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Try reading data from the 'items' key. If it doesn't exist, returns null.
  List<String>? words = prefs.getStringList(allWords);

  words ??= [];
  if (!words.contains(newWord)) {
    words.add(newWord);
  }

  // Save an list of strings to 'items' key.
  await prefs.setStringList(allWords, words);
}
