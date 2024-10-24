import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChartController extends GetxController {
  late final WebViewController webViewController;

  String url =
      'https://www.multicoincharts.com/?c=OANDA:XAUUSD,OANDA:NZDUSD,OANDA:GBPUSD,BINANCE:BTCUSDT';
  RxInt loadingPercentage = 0.obs;

  @override
  void onInit() {
    webViewController = WebViewController()
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          loadingPercentage(0);
        },
        onProgress: (progress) {
          loadingPercentage(progress);
        },
        onPageFinished: (url) {
          loadingPercentage(100);
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.onInit();
  }
}
