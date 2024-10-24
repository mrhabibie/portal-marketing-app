import 'dart:async';

import 'package:bps_portal_marketing/domain/core/model/home/response/price_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/price.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../domain/core/interfaces/api_response.dart';
import '../../../../domain/core/model/base_response.dart';
import '../../../../domain/core/model/failed_response.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class DashboardController extends GetxController implements ApiResponse {
  RxBool isLoading = false.obs;
  late final PriceProvider _provider = PriceProvider(this);
  PriceResponse? price;

  // PriceList? priceList;
  DateTime currentDate = DateTime.now();
  PackageInfo? packageInfo;
  Timer? _timerPrice;

  /*double _threshold = 0;
  double _thresholdShown = 0;*/
  Rx<Color> animatedColor = Pallet.secondary600.obs;
  Timer? _timerColor;

  void getPrice() {
    _provider.getPrice();
  }

  @override
  void onInit() {
    getPrice();
    _timerColor = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      Color color = animatedColor.value == Pallet.secondary600
          ? Pallet.neutral900
          : Pallet.secondary600;
      animatedColor(color);
    });
    super.onInit();
  }

  @override
  void onClose() {
    _timerPrice?.cancel();
    _timerColor?.cancel();
    super.onClose();
  }

  @override
  void onFailedRequest(String path, FailedResponse? failed) {
    AppDialog(
      title: 'whoops-text'.tr,
      description: failed?.data ?? 'error-text'.tr,
      isSuccess: false,
    );
  }

  @override
  void onFinishRequest(String path) {
    isLoading(false);
  }

  @override
  void onStartRequest(String path) {
    isLoading(true);
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    price = response.data;

    /*_threshold = FRCService.to.getDouble('threshold');
    _thresholdShown = FRCService.to.getDouble('threshold_shown');

    priceList = PriceList(data: []);
    price?.toJson().forEach((key, value) {
      if (key.contains('harga')) {
        RegExp reg = RegExp(r'.{2}');
        matchFunc(Match match) => '${match[0]}.';
        String name = key.replaceAll('harga', '');
        if (name.length > 2) {
          name = name.replaceAllMapped(reg, matchFunc);
        }

        if ((double.tryParse(name) ?? 0) >= _thresholdShown) {
          priceList?.data.add(Datum(
            name: name,
            price: value,
            isThreshold: name == _threshold.toString(),
          ));
        }
      }
    });*/

    currentDate = DateTime.now();
    refresh();

    _timerPrice = Timer.periodic(const Duration(minutes: 5), (timer) {
      getPrice();
      _timerPrice?.cancel();
    });
  }
}
