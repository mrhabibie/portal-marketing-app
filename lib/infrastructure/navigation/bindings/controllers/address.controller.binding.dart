import 'package:bps_portal_marketing/presentation/home/telemarketing/address/controllers/new.controller.dart';
import 'package:get/get.dart';

class AddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAddressController>(() => NewAddressController());
  }
}
