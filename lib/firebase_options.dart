import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions sandboxAndroid = FirebaseOptions(
    apiKey: 'CLIENT_API_KEY',
    appId: 'CLIENT_MOBILESDK_APP_ID',
    messagingSenderId: 'PROJECT_INFO_PROJECT_NUMBER',
    projectId: 'PROJECT_INFO_PROJECT_ID',
    storageBucket: 'PROJECT_INFO_STORAGE_BUCKET',
    androidClientId: 'GOOGLE_OAUTH2_CLIENT_ID',
  );

  static const FirebaseOptions sandboxIOS = FirebaseOptions(
    apiKey: 'CLIENT_API_KEY',
    appId: 'CLIENT_MOBILESDK_APP_ID',
    messagingSenderId: 'PROJECT_INFO_PROJECT_NUMBER',
    projectId: 'PROJECT_INFO_PROJECT_ID',
    storageBucket: 'PROJECT_INFO_STORAGE_BUCKET',
    androidClientId: 'GOOGLE_OAUTH2_CLIENT_ID',
    iosClientId: 'GOOGLE_OAUTH2_CLIENT_ID',
    iosBundleId: 'CLIENT_CLIENT_INFO_IOS_CLIENT_INFO_PACKAGE_NAME',
  );

  static const FirebaseOptions prodAndroid = FirebaseOptions(
    apiKey: 'CLIENT_API_KEY',
    appId: 'CLIENT_MOBILESDK_APP_ID',
    messagingSenderId: 'PROJECT_INFO_PROJECT_NUMBER',
    projectId: 'PROJECT_INFO_PROJECT_ID',
    storageBucket: 'PROJECT_INFO_STORAGE_BUCKET',
    androidClientId: 'GOOGLE_OAUTH2_CLIENT_ID',
  );

  static const FirebaseOptions prodIOS = FirebaseOptions(
    apiKey: 'CLIENT_API_KEY',
    appId: 'CLIENT_MOBILESDK_APP_ID',
    messagingSenderId: 'PROJECT_INFO_PROJECT_NUMBER',
    projectId: 'PROJECT_INFO_PROJECT_ID',
    storageBucket: 'PROJECT_INFO_STORAGE_BUCKET',
    androidClientId: 'GOOGLE_OAUTH2_CLIENT_ID',
    iosClientId: 'GOOGLE_OAUTH2_CLIENT_ID',
    iosBundleId: 'CLIENT_CLIENT_INFO_IOS_CLIENT_INFO_PACKAGE_NAME',
  );
}
