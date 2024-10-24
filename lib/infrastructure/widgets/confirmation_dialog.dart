import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme.dart';
import 'widgets.dart';

class ConfirmationDialog {
  ConfirmationDialog({
    required BuildContext context,
    String? title,
    String? subTitle,
    String? cancelLabel,
    String? okLabel,
    void Function()? onBackPressed,
    void Function()? onPressed,
  }) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  title ?? 'confirm-title-text'.tr,
                  style: TextStyles.largeNormalBold,
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: AppDimension.style14),
                  child: Text(
                    subTitle ?? '',
                    style: TextStyles.regularNormalRegular,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: AppDimension.style20,
                    top: AppDimension.style30,
                    right: AppDimension.style20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: RoundedButtonWidget(
                          label: cancelLabel ?? 'cancel-text'.tr,
                          backgroundColor: Pallet.neutralWhite,
                          textColor: Pallet.neutral700,
                          onPressed: onBackPressed ?? () => Get.back(),
                        ),
                      ),
                      SizedBox(width: AppDimension.width20),
                      Expanded(
                        child: RoundedButtonWidget(
                          label: okLabel ?? 'ok-text'.tr,
                          onPressed: onPressed ?? () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
