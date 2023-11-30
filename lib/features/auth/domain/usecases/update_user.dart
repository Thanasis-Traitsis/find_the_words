import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/user_model.dart';

Future<UserModel?> updateUser({
  required CollectionReference<Map<String, dynamic>> usersCollection,
  required String userId,
}) async {
  // Retrieve user data from Firestore
  DocumentSnapshot userDataSnapshot = await usersCollection.doc(userId).get();

  if (userDataSnapshot.exists) {
    int userLevel = userDataSnapshot['level'];
    int userStage = userDataSnapshot['stage'];
    List userWords = userDataSnapshot['words'];
    int points = userDataSnapshot['points'];
    double progress = userDataSnapshot['progress'];
    List usedStages = userDataSnapshot['usedStages'];

    return UserModel(
      id: userId,
      level: userLevel,
      stage: userStage,
      words: userWords,
      points: points,
      progress: progress,
      usedStages: usedStages,
    );
  }

  return null;
}
