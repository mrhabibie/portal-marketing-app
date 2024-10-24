// To parse this JSON data, do
//
//     final masterUserResponse = masterUserResponseFromJson(jsonString);

import 'dart:convert';

MasterUserResponse masterUserResponseFromJson(String str) =>
    MasterUserResponse.fromJson(json.decode(str));

String masterUserResponseToJson(MasterUserResponse data) =>
    json.encode(data.toJson());

class MasterUserResponse {
  final int id;
  final String? alias;
  final String username;
  final String email;
  final String phoneNumber;
  final String? profilePhoto;
  final int flag;

  MasterUserResponse({
    required this.id,
    this.alias,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.profilePhoto,
    required this.flag,
  });

  factory MasterUserResponse.fromJson(Map<String, dynamic> json) =>
      MasterUserResponse(
        id: json["id"],
        alias: json["alias"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        profilePhoto: json["profile_photo"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "profile_photo": profilePhoto,
        "flag": flag,
      };
}
