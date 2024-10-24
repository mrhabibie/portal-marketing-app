import 'package:bps_portal_marketing/presentation/profile/controllers/profile.controller.dart';
import 'package:get/get.dart';

class ProfileControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
