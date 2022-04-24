import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:mobile_dev_lab2/data/song.dart';
import 'package:http/http.dart' as http;

class MusicRepository {
  final String apiToken = 'b2e2ca4520c1fa32fbe1562256247921';
  final Uri url = Uri.parse('https://api.audd.io/');

  Future<RecognizedSongData?> recognizeSong(String path) async {
    File file = File(path);
    String encodedFile = base64Encode(file.readAsBytesSync());
    log(encodedFile);

    var response = await http.post(url, body: {
      'api_token': apiToken,
      'audio': encodedFile,
      'return': 'apple_music,spotify,deezer',
    });
    print(response.body);
    try {
      return RecognizedSongData.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)) as Map);
    } catch (e) {
      return null;
    }
  }
}
