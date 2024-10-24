import 'package:bps_portal_marketing/presentation/login/controllers/login.controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/theme.dart';
import '../../infrastructure/widgets/widgets.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  Widget _form() {
    return Form(
      key: controller.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          CustomTextInput(
            validator: controller.username,
            hideCaption: true,
            hint: 'username-text'.tr,
            onChanged: (value) {
              controller.checkFilled();
            },
          ),
          const SizedBox(height: 20),
          CustomPasswordInput(
            validator: controller.password,
            hideCaption: true,
            hint: 'password-text'.tr,
            onChanged: (value) {
              controller.checkFilled();
            },
            isNeedForgotPasswordButton: true,
          ),
          SizedBox(height: AppDimension.height16),
          Obx(
            () => RoundedButtonWidget(
              label: 'login-text'.tr,
              onPressed:
                  controller.isFilled.isTrue ? () => controller.login() : null,
            ),
          ),
          SizedBox(height: AppDimension.height16),
          RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: 'dont-have-account-text'.tr,
                  style: TextStyles.smallNormalRegular
                      .copyWith(color: Pallet.neutral600),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.toNamed(Routes.REGISTER),
                  text: " ${'register-text'.tr}",
                  style: TextStyles.smallNormalRegular
                      .copyWith(color: Pallet.purple),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutral200,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Pallet.neutral200,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              var locale = Get.locale;
              Get.updateLocale(locale == const Locale('id')
                  ? const Locale('en')
                  : const Locale('id'));
            },
            icon: Icon(
              Iconsax.language_circle5,
              size: AppDimension.style30,
              color: Pallet.purple,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: Get.height * 0.84,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Iconsax.user,
                  size: AppDimension.height60,
                  color: Pallet.purple,
                ),
                SizedBox(height: AppDimension.height20),
                Text(
                  'welcome-back-text'.tr,
                  style: TextStyles.title3,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyles.title3,
                    children: <TextSpan>[
                      TextSpan(text: 'to-text'.tr),
                      TextSpan(
                        text: ' ${"app-name-text".tr}',
                        style: TextStyles.title3.copyWith(color: Pallet.purple),
                      ),
                    ],
                  ),
                ),
                Text(
                  'hello-login-text'.tr,
                  style: TextStyles.regularNormalRegular
                      .copyWith(color: Pallet.neutral600),
                ),
                _form(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
