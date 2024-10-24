class Routes {
  static Future<String> get initialRoute async {
    return ONBOARDING;

    /*if (PrefHelper.to.getToken() == null) {
      return LOGIN;
    }

    return HOME;*/
  }

  static const String ONBOARDING = '/onboarding';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String FORGOT_PASSWORD = '/forgot';
  static const String HOME = '/home';
  static const String VISIT = '/visit';
  static const String VISIT_CAMERA = '/visit/camera';
  static const String VISIT_ADD_CONTACT = '/visit/add_contact';
  static const String TELEMARKETING = '/telemarketing';
  static const String CONTACT = '/contact';
  static const String FOLLOW_UP = '/follow_up';
  static const String FOLLOW_UP_NEW = '/follow_up/new';
  static const String TELEMARKETING_ADD_TYPE = '/telemarketing/add_type';
  static const String TELEMARKETING_ADD_CONTACT = '/telemarketing/add_contact';
  static const String TELEMARKETING_DETAIL_CONTACT =
      '/telemarketing/detail_contact';
  static const String TELEMARKETING_ADD_ADDRESS = '/telemarketing/add_address';
  static const String PROFILE = '/profile';
  static const String SALES = '/sales';
  static const String SALES_NEW_VISIT = '/sales/visit/add';
  static const String SALES_CAMERA = '/sales/camera';
  static const String SALES_GALLERY = '/sales/gallery';
}
