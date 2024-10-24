import 'package:bps_portal_marketing/presentation/home/controllers/telemarketing.controller.dart';
import 'package:get/get.dart';

class TelemarketingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TelemarketingController>(() => TelemarketingController());
  }
}
