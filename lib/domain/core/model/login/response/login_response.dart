import 'dart:convert';

class LoginResponse {
  final int id;
  final String email;
  final String username;
  final String phoneNumber;
  final String? profilePhoto;
  final String token;

  LoginResponse({
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNumber,
    this.profilePhoto,
    required this.token,
  });

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        phoneNumber: json["phone_number"],
        profilePhoto: json["profile_photo"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "phone_number": phoneNumber,
        "profile_photo": profilePhoto,
        "token": token,
      };
}
