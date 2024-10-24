import 'package:get/get.dart';

import '../../navigation/routes.dart';
import '../../utils/helpers/pref_helper.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  final isLoggedIn = (PrefHelper.to.getToken() != null).obs;

  void login({required String token}) {
    isLoggedIn(true);
    PrefHelper.to.saveToken(token: token);
    Get.offAllNamed(Routes.HOME);
  }

  void logout() {
    isLoggedIn(false);
    PrefHelper.to.removeAuth();
    Get.offAllNamed(Routes.LOGIN);
  }
}
