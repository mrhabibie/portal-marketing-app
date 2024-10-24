import 'package:get/get.dart';

import '../theme/theme.dart';

class SnackbarError {
  final String title;
  final String message;

  SnackbarError(
    this.title,
    this.message,
  ) {
    _showSnackbar();
  }

  void _showSnackbar() {
    Get.snackbar(
      title,
      message,
      backgroundColor: Pallet.primary400,
      colorText: Pallet.neutralWhite,
    );
  }
}
