import 'package:bps_portal_marketing/presentation/home/controllers/contact.controller.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/contact/controllers/detail.controller.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/contact/controllers/new.controller.dart';
import 'package:get/get.dart';

class ContactControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewContactController>(() => NewContactController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<ContactDetailController>(() => ContactDetailController());
  }
}
