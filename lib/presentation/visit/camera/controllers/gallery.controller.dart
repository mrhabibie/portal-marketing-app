import 'dart:io';

import 'package:get/get.dart';

class GalleryScreenController extends GetxController {
  final RxList<File> files = <File>[].obs;

  @override
  void onInit() {
    files(Get.arguments['files']);
    super.onInit();
  }
}
