import 'package:bps_portal_marketing/presentation/home/telemarketing/follow_up/controllers/follow_up.controller.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/follow_up/controllers/new.controller.dart';
import 'package:get/get.dart';

class FollowUpControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowUpController>(() => FollowUpController());
    Get.lazyPut<FollowUpNewController>(() => FollowUpNewController());
  }
}
