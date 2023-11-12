import 'check_direction.dart';
import 'check_neighbors.dart';

bool checkIfSpotsAvailable({
  required List positions,
  required int commonPositionNew,
  required List<String> copyTbList,
  required String newWord,
  required int numRowsAndColumns,
}) {
  // KRATAEI COUNTER GIA NA APOTREPSEI MIA LEKSI NA KOLLISEI OLOKLIRI PANW APO MIA ALLI
  List countCommonLetters = [];

  for (var i = 0; i < positions.length; i++) {
    if (i != commonPositionNew) {
      if (copyTbList[positions[i]] == 'XX') return false;
      if (copyTbList[positions[i]] != '' && copyTbList[positions[i]] != 'X') {
        if (copyTbList[positions[i]] != newWord[i]) return false;
        if (copyTbList[positions[i]] == newWord[i]) {
          countCommonLetters.add(positions[i]);
          if (countCommonLetters.length > 1) {
            print('ΕΠΙΤΕΛΟΥΣ ΠΕΣΑΜΕ ΣΕ ΤΕΤΟΙΑ ΠΕΡΙΠΤΩΣΗ');
            if (countCommonLetters[countCommonLetters.length - 1] -
                    countCommonLetters[countCommonLetters.length - 2] ==
                1) return false;
          }
        }
      }
    }
  }

  return checkNeighbors(
    positions: positions,
    tbList: copyTbList,
    colsAndRows: numRowsAndColumns,
    isHosizontal: checkDirection(positions),
    commonPositionNew: commonPositionNew,
  );
}
