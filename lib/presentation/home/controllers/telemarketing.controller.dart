import 'package:bps_portal_marketing/infrastructure/utils/extension/date.extension.dart';
import 'package:bps_portal_marketing/infrastructure/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/core/interfaces/api_response.dart';
import '../../../domain/core/model/base_response.dart';
import '../../../domain/core/model/failed_response.dart';

class TelemarketingController extends GetxController implements ApiResponse {
  RxBool isLoading = true.obs;
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List<DateTime> weeklyDate = [];
  List<GlobalKey> listKey = [];
  Rx<GlobalKey> activeKey = GlobalKey().obs;
  final ScrollController scrollController = ScrollController();
  RxBool showFab = false.obs;

  final TextValidator search = TextValidator();

  getListDate(DateTime startDate) {
    isLoading(true);

    scrollController.addListener(_scrollListener);

    List<DateTime> days = [];
    List<GlobalKey> keys = [];
    startDate = startDate.subtract(Duration(days: startDate.weekday));
    for (int i = 0; i < startDate.weekday; i++) {
      DateTime day = startDate.add(Duration(days: i));
      if (day.toIdDay.toLowerCase() != 'minggu' &&
          day.toIdDay.toLowerCase() != 'sunday') {
        keys.add(GlobalKey(debugLabel: day.toIdDay));
        days.add(day);
      }
    }
    weeklyDate = days;
    listKey = keys;
    weeklyDate.sort((a, b) => a.compareTo(b));
    isLoading(false);
  }

  void _scrollListener() {
    if (scrollController.offset >= 300) {
      showFab(true);
    } else {
      showFab(false);
    }
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: currentDate,
    );
    selectedDate = pickedDate;
    getListDate(selectedDate);
    }

  @override
  void onInit() {
    getListDate(currentDate);
    super.onInit();
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
