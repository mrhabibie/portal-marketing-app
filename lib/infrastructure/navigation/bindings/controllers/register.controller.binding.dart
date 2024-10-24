import 'package:bps_portal_marketing/presentation/register/controllers/register.controller.dart';
import 'package:get/get.dart';

class RegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
