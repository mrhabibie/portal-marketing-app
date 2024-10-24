import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/theme.dart';
import 'widgets.dart';

class AppDialog {
  final bool? isSuccess;
  final String title;
  final String description;
  final Function? onDone;

  AppDialog({
    this.isSuccess,
    required this.title,
    required this.description,
    this.onDone,
  }) {
    _showDialog();
  }

  void _showDialog() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                isSuccess == null
                    ? Iconsax.info_circle1
                    : isSuccess == true
                        ? Iconsax.tick_circle
                        : Iconsax.warning_2,
                size: 60,
                color: isSuccess == null
                    ? Pallet.info600
                    : isSuccess == true
                        ? Pallet.success600
                        : Pallet.secondary600,
              ),
              SizedBox(height: AppDimension.height20),
              Text(title, style: TextStyles.title3),
              SizedBox(height: AppDimension.height8),
              Text(
                description,
                style: TextStyles.smallNoneRegular
                    .copyWith(color: Pallet.neutral600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimension.height24),
              RoundedButtonWidget(
                label: 'ok-text'.tr,
                onPressed: () {
                  if (onDone == null) {
                    Get.back();
                  } else {
                    onDone!();
                  }
                },
              ),
              SizedBox(height: AppDimension.height24),
            ],
          ),
        );
      },
    );
  }
}
