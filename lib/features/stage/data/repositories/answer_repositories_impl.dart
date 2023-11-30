import 'dart:math';

import 'package:collection/collection.dart';
import 'package:find_the_words/features/stage/domain/usecases/answer_usecases/get_common_positions.dart';

import '../../domain/repositories/answer_repositories.dart';

class AnswerRepositoriesImpl extends AnswerRepositories {
  @override
  Future submitAnswer({
    required String answer,
    required List wordPositions,
    required List<String> tableList,
    required List allStageWords,
    required List answeredPositions,
    required List answeredWords,
  }) async {
    if (!answeredWords.contains(answer)) {
      print('The answer word is: $answer');

      print('The word positions are: $wordPositions');

      print(
          'The unavailable positions because of the answers are : $answeredPositions');

      List commonPositions = getCommonPositions(wordPositions);

      bool hasListWithEqualLength =
          wordPositions.any((list) => list.length == answer.length);
      if (hasListWithEqualLength) {
        List posiblePositions = wordPositions
            .where((list) => list.length == answer.length)
            .toList();

        // Check if any list in filteredLists is not in usedLists
        List availableLists = posiblePositions
            .where((filteredList) => !answeredPositions.contains(filteredList))
            .toList();

        if (availableLists.isNotEmpty) {
          var count = 0;
          print("Available Lists: $availableLists");

          for (var i = 0; i < availableLists.length; i++) {
            bool isMatch = true;
            count++;
            for (var j = 0; j < availableLists[i].length; j++) {
              if (tableList[availableLists[i][j]] != answer[j]) {
                isMatch = false;
                break;
              }
            }

            if (isMatch) {
              print("Match found in available list: ${availableLists[i]}");
              return availableLists[i];
            } else {
              // This is where we can check, if its possible to set another word in this position
              if (count <= availableLists.length) {
                bool isPossible = true;
                if (allStageWords.contains(answer)) {
                  for (var p = 0; p < availableLists[i].length; p++) {
                    if (commonPositions.contains(availableLists[i][p])) {
                      if (tableList[availableLists[i][p]] != answer[p]) {
                        isPossible = false;
                        break;
                      }
                    }
                  }
                } else {
                  isPossible = false;
                }

                if (isPossible) {
                  print("Match found in available list: ${availableLists[i]}");
                  return availableLists[i];
                } else {
                  if (count == availableLists.length) {
                    // This is where we need to check for extra words
                    print(
                        "No match found in available list: ${availableLists[i]}");
                    print("All the words from stage are: $allStageWords");

                    if (await searchForExtraWords(
                        allStageWords: allStageWords, word: answer)) {
                      return [];
                    }
                  }
                }
              }
            }
          }
        } else {
          // This is where we need to check for extra words
          print("No available lists found.");
          print("All the words from stage are: $allStageWords");

          if (await searchForExtraWords(
              allStageWords: allStageWords, word: answer)) {
            return [];
          }
        }
      } else {
        print(
            'The answers word length is not equal with any of the words in stage');
        if (await searchForExtraWords(
            allStageWords: allStageWords, word: answer)) {
          return [];
        }
      }
    } else {
      print('You have already used this word');
    }
  }

  @override
  Future positionHintLetter({
    required List wordPositions,
    required List<String> tableList,
    required List answeredPositions,
    required List unavailablePositions,
  }) async {
    var word = '';
    var randomPosition;

    print('answeredPositions: $answeredPositions');

    // Filter out positions that are already used in answeredPositions
    List availablePositions = wordPositions
        .where((positions) => !answeredPositions.any(
            (answered) => const ListEquality().equals(positions, answered)))
        .toList();

    // Sort availablePositions by length in descending order to get the biggest list first
    availablePositions.sort((a, b) => b.length.compareTo(a.length));

    print('availablePositions: $availablePositions');

    // Select a random position from the biggest available list
    List selectedPositions = availablePositions.first;
    List availableSpots = selectedPositions
        .where((pos) => !unavailablePositions.contains(pos))
        .toList();

    if (availableSpots.isEmpty) {
      return; // No available spots in the selected list
    }

    print('availableSpots: $availableSpots');

    if (availableSpots.length == 1) {
      for (var i = 0; i < selectedPositions.length; i++) {
        word += tableList[selectedPositions[i]];
      }

      randomPosition = selectedPositions;
    } else {
      randomPosition = [
        availableSpots[Random().nextInt(availableSpots.length)]
      ];
    }

    return [randomPosition, word];
  }

  @override
  Future searchForExtraWords({
    required List allStageWords,
    required String word,
  }) async {
    return allStageWords.contains(word);
  }
}
