import 'package:find_the_words/features/stage/data/repositories/crossword_repositories_impl.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/crossword_values.dart';
import '../../domain/repositories/stage_repositories.dart';
import '../../domain/usecases/creating_crossword/apply_changes.dart';
import '../../domain/usecases/creating_crossword/check_if_table_can_be_smaller.dart';
import '../../domain/usecases/creating_crossword/count_available_columns.dart';
import '../../domain/usecases/creating_crossword/count_available_rows.dart';
import '../../domain/usecases/creating_crossword/generate_table_list.dart';
import '../../domain/usecases/creating_crossword/generate_widget_table.dart';
import '../../domain/usecases/creating_crossword/list_direction_small.dart';
import '../../domain/usecases/creating_crossword/move_table_to_center.dart';

class StageRepositoriesImpl extends StageRepositories {
  List<Widget> widgetList = [];
  List<String> tableList = [];
  List wordPositions = [];
  List<String> finalWordsList = [];

  // Edw tha ginontai oi elegxoi twn leksewn, kai an einai ola entaksei tha proxoraei sto createCrossword
  @override
  Future createStage(List wordsList) async {
    for (var i = 0; i < wordsList.length; i++) {
      finalWordsList.add(wordsList[i].toString());
    }

    print(finalWordsList);

    return true;
  }

  // Edw tha ginetai oi arxikopoihsh twn pinakwn kai tha ksekinaei h diadikasia dhmioyrgias toy crossword
  @override
  Future createCrossword() async {
    List errorWords = [];

    int tableBoxes = tableLength;
    int tableRnC = tableRowsAndColumns;

    widgetList = generateWidgetTable(tableBoxes);
    tableList = generateTableList(tableBoxes);

    List<int> listOfStartingPositions =
        List.generate(finalWordsList.length, (index) => 0);

    var returnList = await CrosswordRepositoriesImpl().placeWords(
      widgetList: widgetList,
      tableList: tableList,
      numberOfRowsAndColumns: tableRnC,
      wordsList: finalWordsList,
      listOfStartingPositions: listOfStartingPositions,
    );

    bool shouldContinueLoop = true;

    while (shouldContinueLoop && !returnList[2]) {
      bool tooManyErrors = false;
      shouldContinueLoop = false;

      errorWords.add(returnList[3]);

      for (var i = 0; i < errorWords.length; i++) {
        int occurrences =
            errorWords.where((str) => str == errorWords[i]).length;

        if (occurrences >= 5) {
          print('ΔΕΝ ΠΑΛΕΥΕΤΑΙ ΑΛΛΟ ΑΥΤΗ Η ΛΕΞΗ : ${errorWords[i]}');
          tooManyErrors = true;
          break;
        }
      }

      if (!tooManyErrors) {
        for (int i = 0; i < finalWordsList.length; i++) {
          if (listOfStartingPositions[i] < finalWordsList[i].length - 1) {
            listOfStartingPositions[i] += 1;
            shouldContinueLoop = true;
            break;
          } else {
            listOfStartingPositions[i] = 0;
          }
        }

        print(listOfStartingPositions);

        widgetList = generateWidgetTable(tableBoxes);
        tableList = generateTableList(tableBoxes);

        returnList = await CrosswordRepositoriesImpl().placeWords(
          widgetList: widgetList,
          tableList: tableList,
          numberOfRowsAndColumns: tableRnC,
          wordsList: finalWordsList,
          listOfStartingPositions: listOfStartingPositions,
        );
      }
    }

    if (!shouldContinueLoop) {
      print("ΔΕ ΓΙΝΕΤΑΙ ΝΑ ΦΤΙΑΧΤΕΙ ΕΠΙΠΕΔΟ ΜΕ ΑΥΤΕΣ ΤΙΣ ΛΕΞΕΙΣ ΡΕ ΦΙΛΕ");
    }

    widgetList = returnList[0];
    wordPositions = returnList[1];

    // UNCOMMENT THIS PART FOR THE WHOLE EXPERIENCE
    // await centerTable();
    // widgetList = await makeTableSmaller(tableRnC);

    // UNCOMMENT THIS PART WHEN YOU WANT TO SEE THE RESULT WITHOUT CENTER AND SMALLERTABLE
    widgetList = await applyChanges(
      positions: wordPositions,
      tbList: tableList,
      wdtList: widgetList,
    );
  }

  @override
  Future centerTable() async {
    int halfTableRows = 0;
    int halfTableColumns = 0;

    int counterAboveMiddle = 0;
    int counterBelowMiddle = 0;
    int counterLeftMiddle = 0;
    int counterRightMiddle = 0;

    halfTableRows = (tableRowsAndColumns * (tableRowsAndColumns ~/ 2));
    halfTableColumns = tableRowsAndColumns ~/ 2;

    counterAboveMiddle = countAvailableRows(
      startOfSearch: 0,
      endOfSearch: halfTableRows,
      tableRowsAndColumns: tableRowsAndColumns,
      tableList: tableList,
    );

    counterBelowMiddle = countAvailableRows(
      startOfSearch: halfTableRows,
      endOfSearch: tableList.length,
      tableRowsAndColumns: tableRowsAndColumns,
      tableList: tableList,
    );

    counterLeftMiddle = countAvailableColumns(
      startOfSearch: 0,
      endOfSearch: halfTableColumns,
      tableList: tableList,
      tableRowsAndColumns: tableRowsAndColumns,
    );

    counterRightMiddle = countAvailableColumns(
      startOfSearch: halfTableColumns,
      endOfSearch: tableRowsAndColumns,
      tableList: tableList,
      tableRowsAndColumns: tableRowsAndColumns,
    );

    var centerResults = moveTableToCenter(
      counterAboveMiddle: counterAboveMiddle,
      counterBelowMiddle: counterBelowMiddle,
      counterLeftMiddle: counterLeftMiddle,
      counterRightMiddle: counterRightMiddle,
      tblist: tableList,
      wordPositions: wordPositions,
    );

    tableList = centerResults[0];
    wordPositions = centerResults[1];

    // widgetList = await applyChanges(
    //   positions: wordPositions,
    //   tbList: tableList,
    //   wdtList: widgetList,
    // );
  }

  int smallTable = 0;
  @override
  Future makeTableSmaller(int rowLength) async {
    List tableDirections = [0, 0, 0, 0];

    for (var i = 0; i < tableDirections.length; i++) {
      tableDirections = listDirectionSmall(
        rowLength: rowLength,
        tableDirections: tableDirections,
        tableList: tableList,
        dir: i,
      );
    }

    smallTable = checkIfTableCanBeSmaller(
      tableDirections: tableDirections,
      tableRowsAndColumns: rowLength,
    );

    if (smallTable == 1) {
      var oldRowLength = rowLength;
      rowLength = rowLength - 1;

      var newBoxes = rowLength * rowLength;

      var newTbList = generateTableList(newBoxes);
      var newWidgetList = generateWidgetTable(newBoxes);

      var count = 0;

      if (tableDirections[0] == 1 && tableDirections[1] == 1) {
        // PANW DEKSIA
        for (var i = 1; i <= rowLength; i++) {
          for (var j = 0; j < rowLength; j++) {
            newTbList[count] = tableList[j + (i * oldRowLength)];
            count++;
          }
        }

        for (var i = 0; i < wordPositions.length; i++) {
          for (var j = 0; j < wordPositions[i].length; j++) {
            wordPositions[i][j] -=
                (oldRowLength + (wordPositions[i][j] ~/ oldRowLength) - 1);
          }
        }

        widgetList = await applyChanges(
          positions: wordPositions,
          tbList: newTbList,
          wdtList: newWidgetList,
        );

        tableList = newTbList;

        return widgetList;
      }
      if (tableDirections[1] == 1 && tableDirections[2] == 1) {
        // DEKSIA KATW
        for (var i = 0; i < rowLength; i++) {
          for (var j = 0; j < rowLength; j++) {
            newTbList[count] = tableList[j + (i * oldRowLength)];
            count++;
          }
        }

        for (var i = 0; i < wordPositions.length; i++) {
          for (var j = 0; j < wordPositions[i].length; j++) {
            wordPositions[i][j] -= (wordPositions[i][j] ~/ oldRowLength);
          }
        }

        widgetList = await applyChanges(
          positions: wordPositions,
          tbList: newTbList,
          wdtList: newWidgetList,
        );

        tableList = newTbList;

        return widgetList;
      }
      if (tableDirections[2] == 1 && tableDirections[3] == 1) {
        // KATW ARISTERA
        for (var i = 0; i < rowLength; i++) {
          for (var j = 1; j <= rowLength; j++) {
            newTbList[count] = tableList[j + (i * oldRowLength)];
            count++;
          }
        }

        for (var i = 0; i < wordPositions.length; i++) {
          for (var j = 0; j < wordPositions[i].length; j++) {
            wordPositions[i][j] -= (wordPositions[i][j] ~/ oldRowLength) + 1;
          }
        }

        widgetList = await applyChanges(
          positions: wordPositions,
          tbList: newTbList,
          wdtList: newWidgetList,
        );

        tableList = newTbList;

        return widgetList;
      }
      if (tableDirections[0] == 1 && tableDirections[3] == 1) {
        print('PANW ARISTERA');
      }
    }

    if (smallTable == 2) {
      var oldRowLength = rowLength;
      rowLength = rowLength - 2;

      var newBoxes = rowLength * rowLength;

      var newTbList = generateTableList(newBoxes);
      var newWidgetList = generateWidgetTable(newBoxes);

      var count = 0;

      for (var i = 1; i <= rowLength; i++) {
        for (var j = 1; j <= rowLength; j++) {
          newTbList[count] = tableList[j + (i * oldRowLength)];
          count++;
        }
      }

      for (var i = 0; i < wordPositions.length; i++) {
        for (var j = 0; j < wordPositions[i].length; j++) {
          wordPositions[i][j] -= (oldRowLength +
              1 +
              (2 * ((wordPositions[i][j] ~/ oldRowLength) - 1)));
        }
      }

      widgetList = await applyChanges(
        positions: wordPositions,
        tbList: newTbList,
        wdtList: newWidgetList,
      );

      tableList = newTbList;
    }

    while (smallTable == 2) {
      widgetList = await makeTableSmaller(rowLength);
    }

    return widgetList;
  }
}
