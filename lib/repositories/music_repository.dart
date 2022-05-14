import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_dev_lab2/auth/user_auth_repository.dart';
import 'package:mobile_dev_lab2/data/song.dart';
import 'package:http/http.dart' as http;

class MusicRepository {
  final String apiToken = 'fea9a76f33a146e4cfea1e1e8fd4b1e5';
  final Uri url = Uri.parse('https://api.audd.io/');
  final favoritesRef = FirebaseFirestore.instance
      .collection("users")
      .doc(UserAuthRepository.getCurrentUserID())
      .collection("favorites")
      .withConverter<FirebaseSong>(
          fromFirestore: (snapshot, options) =>
              FirebaseSong.fromJson(snapshot.data()!),
          toFirestore: (song, _) => song.toJson());

  Future<RecognizedSongData?> recognizeSong(String path) async {
    File file = File(path);
    String encodedFile = base64Encode(file.readAsBytesSync());
    log(encodedFile);

    var response = await http.post(url, body: {
      'api_token': apiToken,
      'audio': encodedFile,
      'return': 'apple_music,spotify,deezer',
    });
    try {
      return RecognizedSongData.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)) as Map);
    } catch (e) {
      return null;
    }
  }

  Future<String> addToFavorites(RecognizedSongData songData) async {
    DocumentReference doc =
        await favoritesRef.add(FirebaseSong.fromRecognizedSongData(songData));
    return doc.id;
  }

  Future<void> removeFromFavorites(String id) async {
    await favoritesRef.doc(id).delete();
  }
}
