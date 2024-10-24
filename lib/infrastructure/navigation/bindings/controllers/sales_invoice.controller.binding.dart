import 'package:bps_portal_marketing/presentation/home/telemarketing/sales/controllers/sales.controller.dart';
import 'package:get/get.dart';

class SalesInvoiceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesInvoiceController>(() => SalesInvoiceController());
  }
}
