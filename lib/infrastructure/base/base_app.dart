import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import '../../config.dart';
import '../dal/services/auth_service.dart';
import '../navigation/navigation.dart';
import '../theme/theme.dart';
import '../utils/helpers/helper.dart';
import '../utils/resources/strings.dart';
import '../widgets/check_connection_dialog.dart';

class MyApp extends StatefulWidget {
  const MyApp(this.initialRoute, {super.key});

  final String initialRoute;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String? env = ConfigEnvironments.getEnvironments()["env"];
  StreamSubscription? subscription;
  bool isShowDialog = false;
  Timer? _debounce;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'appName',
    packageName: 'packageName',
    version: 'version',
    buildNumber: 'buildNumber',
  );

  @override
  void initState() {
    _initConnectivity();
    _initDefaultDir();
    _initPackageInfo();
    super.initState();
  }

  _initConnectivity() {
    SimpleConnectionChecker simpleConnectionChecker = SimpleConnectionChecker();
    subscription =
        simpleConnectionChecker.onConnectionChange.listen((connected) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(seconds: 3), () async {
        if (!isShowDialog && !connected) {
          final currentRoutes = Get.currentRoute;
          final argument = Get.arguments;
          Get.back(closeOverlays: true);
          CheckConnectionDialog(onPressed: () {
            Get.offAndToNamed(currentRoutes, arguments: argument);
            setState(() {
              isShowDialog = false;
            });
          });

          setState(() {
            isShowDialog = true;
          });
        }
      });
    });
  }

  _initDefaultDir() {
    AppHelper.setDefaultDir();
  }

  _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (context, child) => GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetMaterialApp(
          title: _packageInfo.appName,
          translations: Strings(),
          locale: const Locale('id'),
          fallbackLocale: const Locale('en'),
          debugShowCheckedModeBanner: env != Environments.PRODUCTION,
          theme: themeLight,
          localizationsDelegates: <LocalizationsDelegate>[
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FallbackLocalizationsDelegate(),
          ],
          supportedLocales: const [Locale('id'), Locale('en')],
          localeResolutionCallback: (locale, supportedLocales) {
            if (supportedLocales.contains(locale)) {
              return locale;
            }

            return const Locale('id');
          },
          initialBinding: BindingsBuilder(() {
            Get.put(AuthService());
          }),
          initialRoute: widget.initialRoute,
          getPages: Nav.routes,
        ),
      ),
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    _debounce?.cancel();
    super.dispose();
  }
}

class FallbackLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      const DefaultMaterialLocalizations();

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<MaterialLocalizations> old) =>
      false;
}
