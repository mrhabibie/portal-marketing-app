import 'package:bps_portal_marketing/presentation/register/controllers/register.controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/theme/theme.dart';
import '../../infrastructure/widgets/widgets.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutral200,
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
              size: AppDimension.height30,
              color: Pallet.purple,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                'hello-register-text'.tr,
                style: TextStyles.regularNormalRegular
                    .copyWith(color: Pallet.neutral600),
              ),
              SizedBox(height: AppDimension.height20),
              Form(
                key: controller.key,
                child: Column(
                  children: <Widget>[
                    CustomTextInput(
                      validator: controller.username,
                      isRequired: true,
                      title: 'username-text'.tr,
                      onChanged: (value) {
                        controller.username.key.currentState!.validate();
                        controller.checkFilled();
                      },
                    ),
                    SizedBox(height: AppDimension.height16),
                    CustomTextInput(
                      validator: controller.email,
                      isRequired: true,
                      title: 'email-text'.tr,
                      onChanged: (value) {
                        controller.email.key.currentState!.validate();
                        controller.checkFilled();
                      },
                    ),
                    SizedBox(height: AppDimension.height16),
                    CustomTextInput(
                      validator: controller.phone,
                      isRequired: true,
                      title: 'phone-text'.tr,
                      onChanged: (value) {
                        controller.email.key.currentState!.validate();
                        controller.checkFilled();
                      },
                    ),
                    SizedBox(height: AppDimension.height16),
                    CustomPasswordInput(
                      validator: controller.password,
                      isRequired: true,
                      title: 'password-text'.tr,
                      onChanged: (value) {
                        controller.password.key.currentState!.validate();
                        controller.checkFilled();
                      },
                    ),
                    SizedBox(height: AppDimension.height16),
                    CustomPasswordInput(
                      validator: controller.passwordConfirmation,
                      isRequired: true,
                      title: 'password-confirmation-text'.tr,
                      onChanged: (value) {
                        controller.passwordConfirmation.key.currentState!
                            .validate();
                      },
                    ),
                    SizedBox(height: AppDimension.height16),
                    RoundedButtonWidget(
                      label: 'register-text'.tr,
                      onPressed: () => controller.register(),
                    ),
                    SizedBox(height: AppDimension.height16),
                    RichText(
                      text: TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'have-account-text'.tr,
                            style: TextStyles.smallNormalRegular
                                .copyWith(color: Pallet.neutral600),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: " ${'login-text'.tr}",
                            style: TextStyles.smallNormalRegular
                                .copyWith(color: Pallet.purple),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
