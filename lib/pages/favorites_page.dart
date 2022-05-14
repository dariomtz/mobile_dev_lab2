import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:mobile_dev_lab2/auth/user_auth_repository.dart';
import 'package:mobile_dev_lab2/data/song.dart';
import 'package:mobile_dev_lab2/repositories/music_repository.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
        ),
        body: FirestoreListView<FirebaseSong>(
            query: FirebaseFirestore.instance
                .collection('users')
                .doc(UserAuthRepository.getCurrentUserID())
                .collection('favorites')
                .withConverter<FirebaseSong>(
                    fromFirestore: (snapshot, options) =>
                        FirebaseSong.fromJson(snapshot.data()!),
                    toFirestore: (song, _) => song.toJson()),
            itemBuilder: (context, snap) =>
                Song(song: snap.data(), id: snap.id)));
  }
}

class Song extends StatelessWidget {
  final FirebaseSong song;
  final String id;
  const Song({Key? key, required this.song, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Image.network(
              song.image,
              width: MediaQuery.of(context).size.width,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Remove from favorites"),
                                content: const Text(
                                    "This action cannot be undone. Are you sure?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel")),
                                  ElevatedButton(
                                      onPressed: () {
                                        MusicRepository musicRepository =
                                            MusicRepository();
                                        musicRepository.removeFromFavorites(id);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Confirm"))
                                ],
                              ));
                    },
                    icon: const Icon(Icons.favorite)),
                Column(
                  children: [
                    Text(song.title),
                    Text(song.artist),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
