import 'package:geocoding/geocoding.dart' as Geocoding;
import 'package:get_storage/get_storage.dart';

class PrefHelper {
  static final PrefHelper to = PrefHelper._singleTon();

  factory PrefHelper() {
    return to;
  }

  PrefHelper._singleTon();

  late final GetStorage storage;

  Future<void> initStorage() async {
    await GetStorage.init('bps_portal_marketing');
    storage = GetStorage('bps_portal_marketing');
  }

  void saveToken({required String token}) {
    storage.write('token', token);
  }

  String? getToken() {
    if (storage.read('token') != null) return storage.read('token');
    return null;
  }

  void removeAuth() {
    storage.remove('token');
  }

  void saveLocation({required List<Geocoding.Placemark> placemarks}) async {
    storage.write('last_location', placemarks.toList().toString());
  }

  String? getLocation() {
    if (storage.read('last_location') != null) {
      return storage.read('last_location');
    }
    return null;
  }

  void saveDirectory({required String photoPath}) {
    storage.write('photo_path', photoPath);
  }

  String? getDirectory() {
    if (storage.read('photo_path') != null) return storage.read('photo_path');
    return null;
  }

  void saveFilename({required String filename}) {
    storage.write('filename', filename);
  }

  String? getFilename() {
    if (storage.read('filename') != null) return storage.read('filename');
    return null;
  }

  bool? getSaveOriPhoto() {
    return storage.read('save_ori_photo') ?? false;
  }

  void saveFcmToken({required String token}) {
    storage.write("fcm_token", token);
  }

  String? getFcmToken() {
    if (storage.read("fcm_token") != null) return storage.read("fcm_token");
    return null;
  }
}
