import 'package:bps_portal_marketing/presentation/chart/controllers/chart.controller.dart';
import 'package:bps_portal_marketing/presentation/home/controllers/home.controller.dart';
import 'package:bps_portal_marketing/presentation/home/controllers/telemarketing_dashboard.controller.dart';
import 'package:bps_portal_marketing/presentation/home/controllers/visit.controller.dart';
import 'package:bps_portal_marketing/presentation/home/dashboard/controllers/dashboard.controller.dart';
import 'package:get/get.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitController>(() => VisitController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TelemarketingDashboardController>(
        () => TelemarketingDashboardController());
    Get.lazyPut<ChartController>(() => ChartController());
  }
}
