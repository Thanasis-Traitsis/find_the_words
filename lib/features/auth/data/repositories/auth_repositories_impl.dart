import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_words/features/auth/domain/usecases/update_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/initial_values.dart';
import '../../../../current_stage.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../models/user_model.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  String? userId;
  CollectionReference<Map<String, dynamic>>? usersCollection;
  UserModel? user;

  @override
  Future getUser() async {
    bool useridExists = false;

    String? newID = FirebaseAuth.instance.currentUser?.uid;
    usersCollection = FirebaseFirestore.instance.collection('users');
    var idList = await usersCollection!.get();

    idList.docs.forEach((doc) {
      if (newID == doc.id) {
        useridExists = true;
      }
    });

    if (FirebaseAuth.instance.currentUser == null || !useridExists) {

      // Create an anonymous user
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      userId = userCredential.user!.uid;

      // Store user data in the "users" collection
      usersCollection = FirebaseFirestore.instance.collection('users');

      // Initialize user values
      usersCollection!.doc(userId).set({
        'createdAt': time,
        'level': level,
        'stage': stage,
        'points': points,
        'progress': progress,
        'words': words,
        'usedStages': usedStages,
      });

      user = await updateUser(
        usersCollection: usersCollection!,
        userId: userId!,
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Save an list of strings to 'items' key.
      await prefs.setStringList(allWords, user!.words!);
      await prefs.setInt(userPoints, user!.points!);

      print(user);
    } else {
      // User is already logged in, retrieve the user ID
      userId = FirebaseAuth.instance.currentUser!.uid;
      usersCollection = FirebaseFirestore.instance.collection('users');

      bool restart = false;

      if (restart) {
        // Update the user data fields instead of setting them again
        usersCollection!.doc(userId).update({
          'updatedAt': time,
          'level': level,
          'stage': stage,
          'points': points,
          'progress': progress,
          'words': words,
          'usedStages': usedStages,
        });

        user = await updateUser(
          usersCollection: usersCollection!,
          userId: userId!,
        );

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        // Save an list of strings to 'items' key.
        await prefs.setStringList(allWords, user!.words!);
        await prefs.setInt(userPoints, user!.points!);
        prefs.setStringList(extraWordsList, []);

        var stageBox = Hive.box<CurrentStage>(currentStageBox);
        await stageBox.delete(currentStageBox);
      } else {
        user = await updateUser(
          usersCollection: usersCollection!,
          userId: userId!,
        );
      }

      print(user);
    }
  }

  @override
  Future updateUserAfterStage({
    required UserModel userStage,
    required String stageKey,
    required List<String> allTheWords,
    required int userPoints,
    required double progress,
    required bool levelUp,
  }) async {
    usersCollection = FirebaseFirestore.instance.collection('users');

    List newUsedStages = userStage.usedStages!;
    newUsedStages.add(stageKey);

    double prog = levelUp ? 0 : progress;
    int lvl = levelUp ? userStage.level! + 1 : userStage.level!;

    usersCollection!.doc(userId).update({
      'stage': userStage.stage! + 1,
      'usedStages': newUsedStages,
      'words': allTheWords,
      'points': userPoints,
      'progress': prog,
      'level': lvl,
    });

    user = await updateUser(
      usersCollection: usersCollection!,
      userId: userId!,
    );
  }

  @override
  Future deleteUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      userId = userCredential.user!.uid;

      // Store user data in the "users" collection
      usersCollection = FirebaseFirestore.instance.collection('users');

      // ===============================================
      // DELETE THE DOCUMENT
      usersCollection!.doc(userId).delete();

      // ===============================================
      // DELETE THE USER
      await FirebaseAuth.instance.currentUser!.delete();

      // ===============================================
      // DELETE THE LOCAL VARIABLES
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setStringList(extraWordsList, []);

      var stageBox = Hive.box<CurrentStage>(currentStageBox);
      await stageBox.delete(currentStageBox);
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == "requires-recent-login") {
        await reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      print(e);

      // Handle general exception
    }
  }

  Future reauthenticateAndDelete() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }
}
