import 'dart:convert';

class SuccessResponse {
  final int status;
  final String message;
  final int responseCode;
  final String data;

  SuccessResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory SuccessResponse.fromRawJson(String str) =>
      SuccessResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      SuccessResponse(
        status: json["status"],
        message: json["message"],
        responseCode: json["response_code"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "response_code": responseCode,
        "data": data,
      };
}
