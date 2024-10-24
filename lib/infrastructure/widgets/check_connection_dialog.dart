import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme.dart';

class CheckConnectionDialog {
  CheckConnectionDialog({required this.onPressed}) {
    _showDialog();
  }

  final VoidCallback onPressed;

  void _showDialog() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "connection-error-text".tr,
                style: TextStyles.largeNormalBold,
              ),
              Text(
                "check-connection-text".tr,
                style: TextStyles.regularNormalRegular,
              ),
            ],
          ),
        );
      },
    );
  }
}
