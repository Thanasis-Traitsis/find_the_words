abstract class StageRepositories {
  Future createStage(List wordsList);

  Future createCrossword();

  Future centerTable();

  Future makeTableSmaller(int rowLength);
}
