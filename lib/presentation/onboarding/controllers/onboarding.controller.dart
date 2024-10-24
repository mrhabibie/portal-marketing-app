import 'package:bps_portal_marketing/domain/core/interfaces/api_response.dart';
import 'package:bps_portal_marketing/domain/core/model/base_response.dart';
import 'package:bps_portal_marketing/domain/core/model/failed_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/profile.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/core/network/api_url.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../../infrastructure/widgets/widgets.dart';

class OnBoardingController extends GetxController implements ApiResponse {
  late final ProfileProvider _provider = ProfileProvider(this);

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    isLoading(true);
    _provider.getProfile();
    super.onInit();
  }

  @override
  void onFailedRequest(String path, FailedResponse? failed) {
    if (failed?.responseCode == 401) {
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Pallet.danger700,
        duration: const Duration(milliseconds: 1500),
        messageText: Text(
          failed?.data ?? 'error-text'.tr,
          style: TextStyles.regularNormalRegular.copyWith(
            color: Pallet.neutralWhite,
          ),
        ),
      ));
      Get.offAndToNamed(Routes.LOGIN);
    } else {
      AppDialog(
        isSuccess: false,
        title: 'whoops-text'.tr,
        description: failed?.data ?? 'error-text'.tr,
      );
    }
  }

  @override
  void onFinishRequest(String path) {
    switch (path) {
      case ApiUrl.profile:
        isLoading(false);
        break;
    }
  }

  @override
  void onStartRequest(String path) {
    switch (path) {
      case ApiUrl.profile:
        isLoading(true);
        break;
    }
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.profile:
        Get.offAndToNamed(Routes.HOME);
        break;
    }
  }
}
