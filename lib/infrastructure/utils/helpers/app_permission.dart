import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';

class AppPermission {
  Future<String> getDefaultDir() async {
    String dir;

    if (Platform.isIOS) {
      dir = (await getApplicationDocumentsDirectory()).path;
    } else {
      dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DCIM);
    }

    dir = '$dir/Kamera GPS Lokasi/';

    if (!Directory(dir).existsSync()) {
      Directory(dir).createSync(recursive: true);
    }

    return dir;
  }
}
