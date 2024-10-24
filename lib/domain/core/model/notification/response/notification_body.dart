// To parse this JSON data, do
//
//     final notificationBody = notificationBodyFromJson(jsonString);

import 'dart:convert';

NotificationBody notificationBodyFromJson(String str) =>
    NotificationBody.fromJson(json.decode(str));

String notificationBodyToJson(NotificationBody data) =>
    json.encode(data.toJson());

class NotificationBody {
  final String title;
  final String text;
  String? image;
  String? name;

  NotificationBody({
    required this.title,
    required this.text,
    this.image,
    this.name,
  });

  factory NotificationBody.fromJson(Map<String, dynamic> json) =>
      NotificationBody(
        title: json["title"],
        text: json["text"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "image": image,
        "name": name,
      };
}
