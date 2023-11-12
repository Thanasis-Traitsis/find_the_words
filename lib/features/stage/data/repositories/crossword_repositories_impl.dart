import 'package:find_the_words/features/stage/domain/usecases/place_first_word.dart';
import 'package:find_the_words/features/stage/domain/usecases/place_neighbors.dart';
import 'package:flutter/widgets.dart';

import '../../domain/repositories/crossword_repositories.dart';
import '../../domain/usecases/apply_chanegs.dart';
import '../../domain/usecases/check_common_letter.dart';
import '../../domain/usecases/position_word_center.dart';

class CrosswordRepositoriesImpl extends CrosswordRepositories {
  bool firstIsHotizontal = true;
  List wordsPositionList = [];
  String firstWord = '';

  List<String> tbList = [];
  List<Widget> wdtList = [];
  List<String> stageWords = [];
  int numRowsAndColumns = 0;

  @override
  Future placeWords({
    required List<String> tableList,
    required List<Widget> widgetList,
    required int numberOfRowsAndColumns,
    required List<String> wordsList,
  }) async {
    tbList = tableList;
    wdtList = widgetList;
    numRowsAndColumns = numberOfRowsAndColumns;
    firstWord = wordsList[0];
    stageWords = wordsList;

    await fillTableWithWords();

    return [wdtList, wordsPositionList];
  }

  @override
  Future fillTableWithWords() async {
    // VALE TIN PROTI LEKSI STO KENTRO TOY CROSSWORD

    int centerPosition = firstIsHotizontal
        ? positionWordCenterHorizontaly(
            tableLength: tbList.length,
            word: firstWord,
          )
        : 0;

    wordsPositionList.add(
      placeFirstWord(
        word: firstWord,
        center: centerPosition,
        tbList: tbList,
        isHosizontal: firstIsHotizontal,
      ),
    );

    placeNeighbors(
      positions: wordsPositionList[0],
      tbList: tbList,
      colsAndRows: numRowsAndColumns,
    );

    // wdtList = await applyChanges(
    //   positions: wordsPositionList[0],
    //   tbList: tbList,
    //   wdtList: wdtList,
    // );

    // GIA OLES TIS YPOLOIPES LEKSEIS

    for (var i = 1; i < stageWords.length; i++) {
      // TO COUNTER GIA NA VLEPW POSES LEKSEIS PISW PIGA MEXRI NA VRW KOINO GRAMMA
      int availableWord = 1;
      bool stopSearch = false;

      while (!stopSearch && (i - availableWord) >= 0) {
        stopSearch = checkCommonLetter(
          previousWordPosition: wordsPositionList[i - availableWord],
          previousWord: stageWords[i - availableWord],
          newWord: stageWords[i],
          numRowsAndColumns: numRowsAndColumns,
          tbList: tbList,
          wdtList: wdtList,
          wordsPositionList: wordsPositionList,
        );

        if (!stopSearch) availableWord++;
      }

      if (!((i - availableWord) >= 0)) {
        print('EXOUME THEMA ME MIA LEKSI : ${stageWords[i]}');
      }
    }
  }
}
