import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme.dart';

class LoadingDialog {
  LoadingDialog() {
    _showDialog();
  }

  void _showDialog() {
    Get.dialog(
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(AppDimension.width20),
              decoration: BoxDecoration(
                color: Pallet.neutralWhite,
                borderRadius: BorderRadius.circular(AppDimension.width10),
              ),
              child: CircularProgressIndicator(
                color: Pallet.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
