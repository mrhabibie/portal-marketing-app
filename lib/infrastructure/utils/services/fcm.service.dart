import 'dart:isolate';

import 'package:bps_portal_marketing/domain/core/model/notification/response/notification_body.dart';
import 'package:bps_portal_marketing/infrastructure/utils/helpers/helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMService {
  static final FCMService to = FCMService._singleTon();

  factory FCMService() {
    return to;
  }

  FCMService._singleTon();

  Future<void> init(FirebaseOptions flavor) async {
    //Initialize Firebase
    await Firebase.initializeApp(
        options: flavor, name: "portal-marketing-18b9f");
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    /// Catch errors that happen outside of the Flutter context
    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair as List<dynamic>;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last as StackTrace?,
        );
      }).sendPort,
    );
  }

  Future<void> cloudMessagingInit() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    try {
      final NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log.d('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        log.d('User granted provisional permission');
      } else {
        log.d('User declined or has not accepted permission');
      }
      // For testing purposes print the Firebase Messaging _token
      final String _token = await _firebaseMessaging.getToken() ?? "";
      log.d("FCM $_token");

      // Save token to sharedPreference
      PrefHelper.to.saveFcmToken(token: _token);
      log.d("FCM Pref ${PrefHelper.to.getFcmToken()}");
    } catch (e) {
      log.d("Error init FCM $e");
    }

    _firebaseNotification();
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // NotificationBody notifBody = NotificationBody.fromJson(message.data);
    // _handleOnClick(notifBody);
  }

  Future<void> _firebaseNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        NotificationBody notifBody = NotificationBody.fromJson(message.data);
        _handleOnClick(notifBody);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      NotificationBody notifBody = NotificationBody.fromJson(event.data);
      _handleOnClick(notifBody);
    });
    notificationOnBackgroundPressed();
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> notificationOnBackgroundPressed() async {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage remoteMessage) async {
        NotificationBody notifBody =
            NotificationBody.fromJson(remoteMessage.data);
        _handleOnClick(notifBody);
      },
    );
  }

  void _handleOnClick(NotificationBody notifBody) {
    log.d("Notification ${notifBody.title} (${notifBody.text}) clicked!");
  }
}
