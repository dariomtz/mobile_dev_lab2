import 'package:flutter/material.dart';
import 'package:mobile_dev_lab2/data/song.dart';
import 'package:mobile_dev_lab2/repositories/music_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class RecognizedSong extends StatefulWidget {
  final RecognizedSongData songData;
  const RecognizedSong({Key? key, required this.songData}) : super(key: key);

  @override
  State<RecognizedSong> createState() => _RecognizedSongState();
}

class _RecognizedSongState extends State<RecognizedSong> {
  late String? firebaseID;
  MusicRepository musicRepository = MusicRepository();

  @override
  void initState() {
    firebaseID = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Here you go"),
        actions: [
          IconButton(
              onPressed: () async {
                if (firebaseID != null) {
                  await musicRepository.removeFromFavorites(firebaseID!);
                  setState(() {
                    firebaseID = null;
                  });
                } else {
                  String id =
                      await musicRepository.addToFavorites(widget.songData);
                  setState(() {
                    firebaseID = id;
                  });
                }
              },
              icon: firebaseID != null
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_outline))
        ],
      ),
      body: Column(children: [
        Image.network(
          widget.songData.image,
          width: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            widget.songData.title,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        Text(
          widget.songData.album,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        Text(
          widget.songData.artist,
          style:
              const TextStyle(fontWeight: FontWeight.w100, color: Colors.white),
        ),
        Text(
          widget.songData.releaseDate,
          style:
              const TextStyle(fontWeight: FontWeight.w100, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (() => launch(widget.songData.spotifyLink)),
                child: Image.asset(
                  "assets/spotify.png",
                  height: 50,
                  width: 50,
                ),
              ),
              GestureDetector(
                onTap: (() => launch(widget.songData.appleLink)),
                child: Image.asset(
                  "assets/apple.png",
                  height: 50,
                  width: 50,
                ),
              ),
              GestureDetector(
                onTap: (() => launch(widget.songData.deezerLink)),
                child: Image.asset(
                  "assets/deezer.png",
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
