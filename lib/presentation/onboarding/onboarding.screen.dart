import 'package:bps_portal_marketing/presentation/onboarding/controllers/onboarding.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../../infrastructure/utils/resources/assets.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutral200,
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: const AssetImage(Assets.icon192x192),
                      width: AppDimension.width120,
                      height: AppDimension.height120,
                    ),
                    SizedBox(height: AppDimension.height10),
                    Text(
                      "app-name-text".tr,
                      style: TextStyles.largeNormalBold,
                    ),
                  ],
                ),
              ),
              controller.isLoading.isTrue
                  ? const CircularProgressIndicator(color: Pallet.info800)
                  : const Center(),
              SizedBox(height: AppDimension.height50),
            ],
          ),
        ),
      ),
    );
  }
}
