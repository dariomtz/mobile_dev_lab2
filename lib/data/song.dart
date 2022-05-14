import 'package:flutter/material.dart';

@immutable
class RecognizedSongData {
  final String artist;
  final String title;
  final String album;
  final String releaseDate;
  final String link;
  final String appleLink;
  final String spotifyLink;
  final String deezerLink;
  final String image;

  const RecognizedSongData({
    required this.artist,
    required this.title,
    required this.album,
    required this.releaseDate,
    required this.link,
    required this.appleLink,
    required this.spotifyLink,
    required this.deezerLink,
    required this.image,
  });

  RecognizedSongData.fromJson(json)
      : this(
          artist: json["result"]!["artist"] as String,
          title: json["result"]!["title"] as String,
          album: json["result"]!["album"] as String,
          releaseDate: json["result"]!["release_date"] as String,
          link: json["result"]!["song_link"] as String,
          appleLink: json["result"]!["apple_music"]["url"] as String,
          spotifyLink:
              json["result"]!["spotify"]["external_urls"]["spotify"] as String,
          deezerLink: json["result"]!["deezer"]["link"] as String,
          image:
              json["result"]!["spotify"]["album"]["images"][0]["url"] as String,
        );
}

@immutable
class FirebaseSong {
  final String artist;
  final String title;
  final String album;
  final String releaseDate;
  final String link;
  final String image;

  const FirebaseSong({
    required this.artist,
    required this.title,
    required this.album,
    required this.releaseDate,
    required this.link,
    required this.image,
  });

  FirebaseSong.fromJson(Map<String, dynamic> json)
      : this(
          artist: json["artist"]!,
          title: json["title"]!,
          album: json["album"]!,
          releaseDate: json["releaseDate"]!,
          link: json["link"]!,
          image: json["image"]!,
        );

  FirebaseSong.fromRecognizedSongData(RecognizedSongData songData)
      : this(
          artist: songData.artist,
          title: songData.title,
          album: songData.album,
          releaseDate: songData.releaseDate,
          link: songData.link,
          image: songData.image,
        );

  Map<String, String> toJson() {
    return {
      'artist': artist,
      'title': title,
      'album': album,
      'releaseDate': releaseDate,
      'link': link,
      'image': image,
    };
  }
}
