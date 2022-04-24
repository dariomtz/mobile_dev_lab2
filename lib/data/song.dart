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

  const RecognizedSongData({
    required this.artist,
    required this.title,
    required this.album,
    required this.releaseDate,
    required this.link,
    required this.appleLink,
    required this.spotifyLink,
    required this.deezerLink,
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
        );
}

@immutable
class FirebaseSong {
  final String artist;
  final String title;
  final String album;
  final String releaseDate;
  final String link;

  const FirebaseSong({
    required this.artist,
    required this.title,
    required this.album,
    required this.releaseDate,
    required this.link,
  });

  FirebaseSong.fromJson(Map<String, dynamic> json)
      : this(
          artist: json["artist"]!,
          title: json["title"]!,
          album: json["album"]!,
          releaseDate: json["releaseDate"]!,
          link: json["link"]!,
        );

  Map<String, String> toJson() {
    return {
      'artist': artist,
      'title': title,
      'album': album,
      'releaseDate': releaseDate,
      'link': link,
    };
  }
}
