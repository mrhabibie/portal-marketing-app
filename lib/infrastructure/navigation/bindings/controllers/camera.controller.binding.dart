import 'package:bps_portal_marketing/presentation/visit/camera/controllers/camera.controller.dart';
import 'package:bps_portal_marketing/presentation/visit/camera/controllers/gallery.controller.dart';
import 'package:get/get.dart';

class CameraControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraScreenController>(() => CameraScreenController());
    Get.lazyPut<GalleryScreenController>(() => GalleryScreenController());
  }
}
