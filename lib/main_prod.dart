import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'config.dart';
import 'firebase_options.dart';
import 'infrastructure/base/base_app.dart';
import 'infrastructure/navigation/routes.dart';
import 'infrastructure/utils/helpers/pref_helper.dart';
import 'infrastructure/utils/services/fcm.service.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    tz.initializeTimeZones();

    await Firebase.initializeApp();
    await ConfigEnvironments.setCurrentEnvironments(Environments.PRODUCTION);
    if (Platform.isAndroid) {
      await FCMService.to.init(DefaultFirebaseOptions.prodAndroid);
    } else {
      await FCMService.to.init(DefaultFirebaseOptions.prodIOS);
    }
    await PrefHelper.to.initStorage();
    await FCMService.to.cloudMessagingInit();
    // await FCFService.to.init();
    var initialRoute = await Routes.initialRoute;
    runApp(MyApp(initialRoute));
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
