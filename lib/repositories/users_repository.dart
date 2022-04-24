import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_dev_lab2/data/users.dart';

class UserRepository {
  final usersRef = FirebaseFirestore.instance
      .collection("users")
      .withConverter<UserData>(
          fromFirestore: (snap, _) => UserData.fromJson(snap.data()!),
          toFirestore: (user, _) => user.toJson());

  Future<void> upsertUser(User user) async {
    final userData = UserData(
        email: user.email!,
        displayName: user.displayName!,
        photoUrl: user.photoURL!);

    await usersRef.doc(user.uid.toString()).set(userData);
  }

  Future<UserData> retrieveUser(String userId) async {
    final snapshot = await usersRef.doc(userId).get();
    return snapshot.data()!;
  }
}
