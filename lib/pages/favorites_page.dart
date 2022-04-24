import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:mobile_dev_lab2/auth/user_auth_repository.dart';
import 'package:mobile_dev_lab2/data/song.dart';
import 'package:url_launcher/link.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({Key? key}) : super(key: key);

  final UserAuthRepository authRepo = UserAuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FirestoreListView<FirebaseSong>(
            query: FirebaseFirestore.instance
                .collection('users')
                .doc(authRepo.getCurrentUserID())
                .collection('favorites')
                .withConverter<FirebaseSong>(
                    fromFirestore: (snapshot, options) =>
                        FirebaseSong.fromJson(snapshot.data()!),
                    toFirestore: (song, _) => song.toJson()),
            itemBuilder: (context, snap) => Song(song: snap.data())));
  }
}

class Song extends StatelessWidget {
  final FirebaseSong song;
  const Song({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(song.title),
          Text(song.album),
          Text(song.artist),
          Text(song.releaseDate),
        ],
      ),
    );
  }
}
