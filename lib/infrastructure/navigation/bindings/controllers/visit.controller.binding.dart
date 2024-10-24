import 'package:bps_portal_marketing/presentation/home/controllers/visit.controller.dart';
import 'package:bps_portal_marketing/presentation/visit/controllers/new.controller.dart';
import 'package:get/get.dart';

class VisitControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitController>(() => VisitController());
    Get.lazyPut<NewVisitController>(() => NewVisitController());
  }
}
