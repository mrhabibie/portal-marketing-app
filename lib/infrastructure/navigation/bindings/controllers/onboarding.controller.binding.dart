import 'package:bps_portal_marketing/presentation/onboarding/controllers/onboarding.controller.dart';
import 'package:get/get.dart';

class OnBoardingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
  }
}
