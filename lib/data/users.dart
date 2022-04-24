import 'package:flutter/material.dart';

@immutable
class UserData {
  final String email;
  final String displayName;
  final String photoUrl;

  const UserData({
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });

  UserData.fromJson(Map<String, Object?> json)
      : this(
          email: json["email"]! as String,
          displayName: json["name"]! as String,
          photoUrl: json["image"]! as String,
        );

  Map<String, Object?> toJson() {
    return {
      "email": email,
      "name": displayName,
      "image": photoUrl,
    };
  }
}
