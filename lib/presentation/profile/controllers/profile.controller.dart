import 'package:bps_portal_marketing/domain/core/model/login/response/login_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/profile.provider.dart';
import 'package:get/get.dart';

import '../../../domain/core/interfaces/api_response.dart';
import '../../../domain/core/model/base_response.dart';
import '../../../domain/core/model/failed_response.dart';
import '../../../infrastructure/widgets/widgets.dart';

class ProfileController extends GetxController implements ApiResponse {
  RxBool isLoading = false.obs;
  late final ProfileProvider _provider = ProfileProvider(this);
  LoginResponse? profile;

  void getProfile() => _provider.getProfile();

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  @override
  void onFailedRequest(String path, FailedResponse? failed) {
    AppDialog(
      isSuccess: false,
      title: 'whoops-text'.tr,
      description: failed?.data ?? 'error-text'.tr,
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
    profile = response.data;
    refresh();
  }
}
