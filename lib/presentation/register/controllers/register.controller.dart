import 'package:bps_portal_marketing/domain/core/model/register/request/register_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/core/interfaces/api_response.dart';
import '../../../domain/core/model/base_response.dart';
import '../../../domain/core/model/failed_response.dart';
import '../../../domain/core/providers/auth.provider.dart';
import '../../../infrastructure/widgets/widgets.dart';

class RegisterController extends GetxController implements ApiResponse {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  late final AuthProvider _provider = AuthProvider(this);
  RxBool isFilled = false.obs;
  RxBool isLoading = false.obs;

  final TextValidator username = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'username-text'.tr});
      }

      return null;
    },
  );
  final TextValidator email = TextValidator(
    inputType: TextInputType.emailAddress,
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'email-text'.tr});
      }

      if (!GetUtils.isEmail(value)) {
        return 'invalid-field-text'.trParams({'field': 'email-text'.tr});
      }

      return null;
    },
  );
  final TextValidator phone = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'phone-text'.tr});
      }

      return null;
    },
  );
  final TextValidator password = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'password-text'.tr});
      }

      if (value.length < 8) {
        return 'min-password-text'.trParams({'length': '8'});
      }

      return null;
    },
  );
  final TextValidator passwordConfirmation = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'
            .trParams({'field': 'password-confirmation-text'.tr});
      }

      if (value.length < 8) {
        return 'min-password-text'.trParams({'length': '8'});
      }

      return null;
    },
  );

  void checkFilled() {
    if (phone.controller!.text.isEmpty ||
        email.controller!.text.isEmpty ||
        username.controller!.text.isEmpty ||
        password.controller!.text.isEmpty ||
        (password.controller?.text.length ?? 0) < 8) {
      isFilled(false);
    } else {
      isFilled(true);
    }
  }

  register() {
    if ((username.key.currentState?.validate() ?? false) &&
        (email.key.currentState?.validate() ?? false) &&
        (phone.key.currentState?.validate() ?? false) &&
        (password.key.currentState?.validate() ?? false) &&
        (passwordConfirmation.key.currentState?.validate() ?? false) &&
        isFilled.isTrue) {
      if (password.controller!.text != passwordConfirmation.controller!.text) {
        AppDialog(
          isSuccess: false,
          title: 'whoops-text'.tr,
          description:
              'not-match-field-text'.trParams({'field': 'password-text'.tr}),
        );
        return;
      }

      _provider.register(
        request: RegisterRequest(
          email: email.controller!.text,
          phoneNumber: phone.controller!.text,
          username: username.controller!.text,
          password: password.controller!.text,
        ),
      );
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
    username.controller?.clear();
    email.controller?.clear();
    phone.controller?.clear();
    password.controller?.clear();
    passwordConfirmation.controller?.clear();

    FocusScope.of(Get.context!).requestFocus(FocusNode());

    AppDialog(
      isSuccess: true,
      title: 'success-text'.tr,
      description: response.data,
    );
  }
}
