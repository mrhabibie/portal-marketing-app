import 'package:bps_portal_marketing/presentation/chart/controllers/chart.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../infrastructure/theme/theme.dart';

class ChartScreen extends GetView<ChartController> {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutral200,
      body: Obx(
        () => Stack(
          children: <Widget>[
            WebViewWidget(controller: controller.webViewController),
            controller.loadingPercentage.value < 100
                ? LinearProgressIndicator(
                    value: controller.loadingPercentage.value / 100)
                : const Center(),
          ],
        ),
      ),
    );
  }
}
