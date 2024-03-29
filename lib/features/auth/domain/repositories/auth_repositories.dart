import '../../data/models/user_model.dart';

abstract class AuthRepositories {
  Future getUser();

  Future updateUserAfterStage({
    required UserModel userStage,
    required String stageKey,
    required List<String> allTheWords,
    required int userPoints,
    required double progress,
    required bool levelUp,
  });

  Future deleteUser();
}
