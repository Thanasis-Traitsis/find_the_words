abstract class StageRepositories {
  Future createStage({
    required List wordsList,
    required int level,
    required double progress,
  });

  Future createCrossword();

  Future centerTable();

  Future makeTableSmaller(int rowLength);
}
