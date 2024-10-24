import 'dart:convert';

class RegisterRequest {
  final String email;
  final String username;
  final String password;
  final String phoneNumber;

  RegisterRequest({
    required this.email,
    required this.username,
    required this.password,
    required this.phoneNumber,
  });

  factory RegisterRequest.fromRawJson(String str) =>
      RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        email: json["email"],
        username: json["username"],
        password: json["password"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "password": password,
        "phone_number": phoneNumber,
      };
}
