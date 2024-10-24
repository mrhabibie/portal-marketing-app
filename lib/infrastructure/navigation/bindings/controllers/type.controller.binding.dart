import 'package:bps_portal_marketing/presentation/home/telemarketing/type/controllers/new.controller.dart';
import 'package:get/get.dart';

class TypeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewTypeController>(() => NewTypeController());
  }
}
