import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../helpers/helper.dart';

class FRCKeys {
  static const threshold = 'threshold';
  static const thresholdPrice = 'threshold_price';
}

class FRCService {
  static final FRCService to = FRCService._singleTon();

  factory FRCService() {
    return to;
  }

  FRCService._singleTon();

  late final FirebaseRemoteConfig _remoteConfig;

  Future<void> init({
    required RemoteConfigSettings settings,
    required Map<String, dynamic> defaultParameters,
  }) async {
    /// Initialize Remote Config
    _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig.setConfigSettings(settings);
    await _remoteConfig.setDefaults(defaultParameters);

    /// Listen for updates in real time
    _remoteConfig.onConfigUpdated.listen((event) async {
      log.d('onConfigUpdated: ${event.updatedKeys.toString()}');
      await _remoteConfig.activate();
    });
  }

  String getString(String key) => _remoteConfig.getString(key);

  bool getBool(String key) => _remoteConfig.getBool(key);

  double getDouble(String key) => _remoteConfig.getDouble(key);

  int getInt(String key) => _remoteConfig.getInt(key);
}
