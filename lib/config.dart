import 'package:bps_portal_marketing/infrastructure/utils/services/frc.service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static const String PRODUCTION = 'prod';
  static const String STAGING = 'dev';
}

class ConfigEnvironments {
  static String _currentEnvironments = Environments.PRODUCTION;
  static final DotEnv _dotEnv = DotEnv();

  static Future<void> setCurrentEnvironments(String environments) async {
    _currentEnvironments = environments;
    await _dotEnv.load(fileName: 'env/.env.$_currentEnvironments');
  }

  static String getCurrentEnvironmentsName() {
    switch (_currentEnvironments) {
      case Environments.PRODUCTION:
        return 'Production';
      case Environments.STAGING:
        return 'Staging';
    }

    return _currentEnvironments;
  }

  static Map<String, String> getEnvironments() {
    return {
      'env': _dotEnv.env["API_URL"] ?? "",
      'api-url': _dotEnv.env["API_URL"] ?? "",
      'api-key': _dotEnv.env["API_KEY"] ?? "",
    };
  }
}

class FirebaseRemoteConfigs {
  static RemoteConfigSettings getSettings() {
    return RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    );
  }

  static Map<String, dynamic> getDefaults() {
    return {
      FRCKeys.threshold: 71.5,
      FRCKeys.thresholdPrice: 73.5,
    };
  }
}
