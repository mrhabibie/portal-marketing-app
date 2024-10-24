import 'package:bps_portal_marketing/presentation/chart/chart.screen.dart';
import 'package:bps_portal_marketing/presentation/home/dashboard/dashboard.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/telemarketing_dashboard.screen.dart';
import 'package:bps_portal_marketing/presentation/visit/visit.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/core/interfaces/api_response.dart';
import '../../../domain/core/model/base_response.dart';
import '../../../domain/core/model/failed_response.dart';

class HomeController extends GetxController implements ApiResponse {
  final RxList<Widget> pages = RxList([
    const DashboardScreen(),
    const TelemarketingDashboardScreen(),
    const VisitScreen(),
    const ChartScreen(),
  ]);
  RxInt currentPageIndex = 0.obs;

  changePage(int index) {
    currentPageIndex(index);
  }

  @override
  void onFailedRequest(String path, FailedResponse? failed) {
    // TODO: implement onFailedRequest
  }

  @override
  void onFinishRequest(String path) {
    // TODO: implement onFinishRequest
  }

  @override
  void onStartRequest(String path) {
    // TODO: implement onStartRequest
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    // TODO: implement onSuccessRequest
  }
}
