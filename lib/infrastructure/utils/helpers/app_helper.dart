import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as Geocoding;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../domain/core/model/model.dart';
import 'helper.dart';

class AppHelper {
  AppHelper._();

  static Locale getCurrentLang(BuildContext context) {
    return Localizations.localeOf(context);
  }

  static Future<bool> setDefaultFilename({
    SettingFilename? setting,
    required DateTime dateTime,
  }) async {
    SettingFilename defaultSetting =
        SettingFilename(list: <SettingFilenameList>[
      SettingFilenameList(
        key: "dnt",
        header: "dt-text".tr,
        isSelected: true,
        body: <SettingFilenameBody>[
          SettingFilenameBody(
            key: "dt",
            title: "dt-text".tr,
            body: DateFormat("yyyyMMdd").format(dateTime),
            isSelected: true,
          ),
          SettingFilenameBody(
            key: "hms",
            title: "hms-text".tr,
            body: DateFormat("hhmsa")
                .format(dateTime)
                .replaceAll(':', '')
                .replaceAll(' ', ''),
            isSelected: true,
          ),
          SettingFilenameBody(
            key: "day",
            title: "day-text".tr,
            body: DateFormat("EEEE").format(dateTime),
            isSelected: false,
          ),
          SettingFilenameBody(
            key: "h",
            title: "24-hour-text".tr,
            body: DateFormat("Hms")
                .format(dateTime)
                .replaceAll(':', '')
                .replaceAll(' ', ''),
            isSelected: false,
          ),
        ],
        isPremium: false,
      ),
      SettingFilenameList(
        key: "sn",
        header: "sequence-number-text".tr,
        isSelected: false,
        body: "1",
        isPremium: false,
      ),
      SettingFilenameList(
        key: "cn1",
        header: "custom-name-text".trParams({'number': '1'}),
        isSelected: true,
        body: "captured-by-text".tr,
        isPremium: true,
      ),
    ]);

    try {
      /**
       * Cek setting yang ada
       */
      String? jsonString = PrefHelper.to.getFilename();

      /**
       * Jika setting sudah ada
       */
      if (jsonString != null) {
        /**
         * Jika mau overwrite setting yg sudah ada
         */
        PrefHelper.to.saveFilename(
            filename: setting?.toRawJson() ?? defaultSetting.toRawJson());
        return true;
      } else {
        /**
         * Jika setting belum ada
         * simpan settingan yang diberikan user
         * atau gunakan settingan default
         */
        if (setting != null) {
          PrefHelper.to.saveFilename(filename: setting.toRawJson());
          return true;
        } else {
          PrefHelper.to.saveFilename(filename: defaultSetting.toRawJson());
          return true;
        }
      }
    } catch (e) {
      log.e(e.toString());
      return false;
    }
  }

  static Future<dynamic> getDefaultFilename({required Type exportAs}) async {
    SettingFilename? setting;
    List<String> placeholder = [];

    setDefaultFilename(dateTime: DateTime.now());

    try {
      String? jsonString = PrefHelper.to.getFilename();
      if (jsonString != null) {
        setting = SettingFilename.fromRawJson(jsonString);

        placeholder = [];
        for (final data in setting.list) {
          if (data.isSelected) {
            if (data.body is String) {
              if (data.isSelected) {
                placeholder.add(data.body!);
              }
            } else if (data.body is List<SettingFilenameBody>) {
              for (final item in data.body) {
                if (item.isSelected) {
                  if (item.key == "h") {
                    placeholder[1] = item.body;
                  } else {
                    placeholder.add(item.body);
                  }
                }
              }
            }
          }
        }

        if (exportAs == String) {
          return '${placeholder.join('_')}.jpg';
        } else if (exportAs == SettingFilename) {
          return setting;
        } else {
          throw Exception('error-text'.tr);
        }
      }
    } catch (e) {
      log.e('getDefaultFileNameSetting: $e');
      rethrow;
    }

    return '-';
  }

  static Future<void> setDefaultDir({SettingPhotoDirs? newDirs}) async {
    String appDir = await getDefaultAppDir();
    String path = 'BPS_Portal_Kamera';

    if (!Directory('$appDir/$path/').existsSync()) {
      Directory('$appDir/$path/').createSync(recursive: true);
    }

    appDir = Directory('$appDir/$path/').path;

    if (newDirs != null) {
      PrefHelper.to.saveDirectory(photoPath: newDirs.toRawJson());
      return;
    }

    String? defaultDir = PrefHelper.to.getDirectory();
    if (defaultDir == null) {
      List<SettingPhotoDir> newDirs = [
        SettingPhotoDir(
          title: "Default",
          dirPath: appDir,
          isSelected: true,
        ),
        SettingPhotoDir(
          title: "Folder 1",
          dirPath: '${appDir}Folder 1',
          isSelected: false,
        ),
        SettingPhotoDir(
          title: "Folder 2",
          dirPath: '${appDir}Folder 2',
          isSelected: false,
        ),
      ];
      SettingPhotoDirs dirs = SettingPhotoDirs(dirs: newDirs);
      PrefHelper.to.saveDirectory(photoPath: dirs.toRawJson());
    }
  }

  static Future<SettingPhotoDirs> getDefaultDir() async {
    SettingPhotoDirs dirs;

    try {
      String? jsonString = PrefHelper.to.getDirectory();
      if (jsonString != null) {
        dirs = SettingPhotoDirs.fromRawJson(jsonString);
      } else {
        dirs = SettingPhotoDirs(dirs: []);
      }
    } catch (e) {
      log.e('getDefaultDir failed: ${e.toString()}');
      rethrow;
    }

    return dirs;
  }

  static Future<String> getDefaultAppDir() async {
    String dir;

    try {
      if (Platform.isIOS) {
        dir = (await getApplicationDocumentsDirectory()).path;
      } else {
        dir = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DCIM);
      }
    } catch (e) {
      log.e('getApplicationDir failed: ${e.toString()}');
      rethrow;
    }

    return dir;
  }

  static Future<List<Geocoding.Placemark>> getLastLocation() async {
    List<Geocoding.Placemark> placemarks = [];

    try {
      String? jsonString = PrefHelper.to.getLocation();
      if (jsonString != null) {
        placemarks = json.decode(jsonString) as List<Geocoding.Placemark>;
      }
    } catch (e) {
      log.e('getLastLocation failed: ${e.toString()}');
    }

    return placemarks;
  }

  static Future<void> setSaveOriPhoto(bool value) async {
    // PrefHelper.to.saveOriPhoto(value);
  }

  static Future<bool> getSaveOriPhoto() async {
    try {
      return PrefHelper.to.getSaveOriPhoto() ?? false;
    } catch (e) {
      log.e('getSaveOriPhoto failed: ${e.toString()}');
      rethrow;
    }
  }

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
  }

  static Future<void> enterFullscreen() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  static Future<void> exitFullscreen() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
  }
}
