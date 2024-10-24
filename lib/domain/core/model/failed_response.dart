import 'dart:convert';

class FailedResponse {
  final int status;
  final String message;
  final int responseCode;
  final String data;

  FailedResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory FailedResponse.fromRawJson(String str) =>
      FailedResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FailedResponse.fromJson(dynamic json) => FailedResponse(
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
