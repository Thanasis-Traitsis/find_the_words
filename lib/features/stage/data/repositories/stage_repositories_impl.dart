import 'package:find_the_words/features/stage/data/repositories/crossword_repositories_impl.dart';
import 'package:find_the_words/features/stage/domain/usecases/check_if_table_can_be_smaller.dart';
import 'package:find_the_words/features/stage/domain/usecases/count_available_rows.dart';
import 'package:find_the_words/features/stage/domain/usecases/generate_table_list.dart';
import 'package:find_the_words/features/stage/domain/usecases/list_direction_small.dart';
import 'package:find_the_words/features/stage/domain/usecases/move_table_to_center.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/crossword_values.dart';
import '../../domain/repositories/stage_repositories.dart';
import '../../domain/usecases/apply_chanegs.dart';
import '../../domain/usecases/count_available_columns.dart';
import '../../domain/usecases/generate_widget_table.dart';
import '../../domain/usecases/is_empty_box.dart';
import '../../domain/usecases/make_table_smaller_by_two.dart';

class StageRepositoriesImpl extends StageRepositories {
  List<Widget> widgetList = [];
  List<String> tableList = [];
  List wordPositions = [];

  // Edw tha ginontai oi elegxoi twn leksewn, kai an einai ola entaksei tha proxoraei sto createCrossword
  @override
  Future createStage() async {
    return true;
  }

  // Edw tha ginetai oi arxikopoihsh twn pinakwn kai tha ksekinaei h diadikasia dhmioyrgias toy crossword
  @override
  Future createCrossword() async {
    int tableBoxes = tableLength;
    int tableRnC = tableRowsAndColumns;

    widgetList = generateWidgetTable(tableBoxes);
    tableList = generateTableList(tableBoxes);

    var returnList = await CrosswordRepositoriesImpl().placeWords(
      widgetList: widgetList,
      tableList: tableList,
      numberOfRowsAndColumns: tableRnC,
      wordsList: ["ΡΕΚΤΟ", "ΚΟΡΤΕ", "ΡΟΚΕ", "ΚΟΤ", "ΟΤΕ", "ΡΟΚ"],
    );

    widgetList = returnList[0];
    wordPositions = returnList[1];

    // UNCOMMENT THIS PART FOR THE WHOLE EXPERIENCE
    await centerTable();
    widgetList = await makeTableSmaller(tableRnC);

    // UNCOMMENT THIS PART WHEN YOU WANT TO SEE THE RESULT WITHOUT CENTER AND SMALLERTABLE
    // widgetList = await applyChanges(
    //   positions: wordPositions,
    //   tbList: tableList,
    //   wdtList: widgetList,
    // );
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
      if (tableDirections[0] == 1 && tableDirections[1] == 1) {
        print('PANW DEKSIA');
      }
      if (tableDirections[1] == 1 && tableDirections[2] == 1) {
        var oldRowLength = rowLength;
        rowLength = rowLength - 1;

        var newBoxes = rowLength * rowLength;

        var newTbList = generateTableList(newBoxes);
        var newWidgetList = generateWidgetTable(newBoxes);

        var count = 0;

        for (var i = 0; i < rowLength; i++) {
          for (var j = 0; j < rowLength; j++) {
            newTbList[count] = tableList[j + (i * oldRowLength)];
            count++;
          }
        }

        for (var i = 0; i < wordPositions.length; i++) {
          for (var j = 0; j < wordPositions[i].length; j++) {
            // wordPositions[i][j] -= (oldRowLength +
            //     1 +
            //     (2 * ((wordPositions[i][j] ~/ oldRowLength) - 1)));
            wordPositions[i][j] -= (wordPositions[i][j] ~/ oldRowLength);
          }
        }

        widgetList = await applyChanges(
          positions: wordPositions,
          tbList: newTbList,
          wdtList: newWidgetList,
        );

        tableList = newTbList;
      }
      if (tableDirections[2] == 1 && tableDirections[3] == 1) {
        print('KATW ARISTERA');
      }
      if (tableDirections[1] == 1 && tableDirections[3] == 1) {
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
