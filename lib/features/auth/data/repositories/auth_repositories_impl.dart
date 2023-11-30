import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_the_words/features/auth/domain/usecases/update_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/initial_values.dart';
import '../../domain/repositories/auth_repositories.dart';
import '../models/user_model.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  String? userId;
  CollectionReference<Map<String, dynamic>>? usersCollection;
  UserModel? user;

  @override
  Future getUser() async {
    if (FirebaseAuth.instance.currentUser == null) {
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

      print(user);
    } else {
      // User is already logged in, retrieve the user ID
      userId = FirebaseAuth.instance.currentUser!.uid;
      usersCollection = FirebaseFirestore.instance.collection('users');

      // Update the user data fields instead of setting them again
      // usersCollection!.doc(userId).update({
      //   'createdAt': time,
      //   'level': level,
      //   'stage': stage,
      //   'points': points,
      //   'progress': progress,
      //   'words': words,
      //   'usedStages': usedStages,
      // });

      user = await updateUser(
        usersCollection: usersCollection!,
        userId: userId!,
      );

      print(user);
    }
  }
}
