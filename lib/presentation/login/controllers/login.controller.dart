import 'package:bps_portal_marketing/domain/core/model/login/request/login_request.dart';
import 'package:bps_portal_marketing/domain/core/model/login/response/login_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/core/interfaces/api_response.dart';
import '../../../domain/core/model/base_response.dart';
import '../../../domain/core/model/failed_response.dart';
import '../../../domain/core/network/api_url.dart';
import '../../../domain/core/providers/auth.provider.dart';
import '../../../infrastructure/dal/services/auth_service.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/widgets/widgets.dart';

class LoginController extends GetxController implements ApiResponse {
  final key = GlobalKey<FormState>(debugLabel: Routes.LOGIN);
  late final AuthProvider _provider = AuthProvider(this);
  final TextValidator username = TextValidator();
  final TextValidator password = TextValidator();
  RxBool isLoading = false.obs;
  RxBool isFilled = false.obs;

  login() async {
    _provider.login(
      request: LoginRequest(
        username: username.controller!.text,
        password: password.controller!.text,
      ),
    );
  }

  void checkFilled() {
    if (username.controller!.text.isEmpty) {
      isFilled(false);
    } else {
      isFilled(true);
    }
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
    switch (path) {
      case ApiUrl.login:
        LoginResponse loginResponse = response.data;
        AuthService.to.login(token: loginResponse.token);
        break;
      default:
    }
  }
}
