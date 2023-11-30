import 'package:find_the_words/core/utils/routes_utils.dart';
import 'package:find_the_words/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:find_the_words/features/stage/data/repositories/answer_repositories_impl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../current_stage.dart';
import '../../../../auth/data/models/user_model.dart';
import 'extra_words_repositories.dart';

Future clearStageAfterCompletion({
  required BuildContext context,
  required String key,
}) async {
  final authRepositoriesImpl = AuthRepositoriesImpl();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Try reading data from the 'items' key. If it doesn't exist, returns null.
  List<String>? words = prefs.getStringList(allWords);

  words ??= [];

  var stageBox = Hive.box<CurrentStage>(currentStageBox);

  await authRepositoriesImpl.getUser();
  UserModel? user = authRepositoriesImpl.user;

  // Updating the user
  await authRepositoriesImpl.updateUserAfterStage(
    userStage: user!,
    stageKey: key,
    allTheWords: words,
  );

  user = authRepositoriesImpl.user;

  // Clearing the stage
  await clearExtraWord();
  await stageBox.delete(currentStageBox);

  context.goNamed(
    PAGES.home.screenName,
    extra: user,
  );
}
