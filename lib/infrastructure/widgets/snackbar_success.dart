import 'package:get/get.dart';

import '../theme/theme.dart';

class SnackbarSuccess {
  final String title;
  final String message;

  SnackbarSuccess(
    this.title,
    this.message,
  ) {
    _showSnackbar();
  }

  void _showSnackbar() {
    Get.snackbar(
      title,
      message,
      backgroundColor: Pallet.success400,
      colorText: Pallet.neutralWhite,
    );
  }
}
