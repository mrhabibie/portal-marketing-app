import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/address.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/camera.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/contact.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/follow_up.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/home.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/login.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/onboarding.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/profile.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/register.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/sales_invoice.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/telemarketing.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/type.controller.binding.dart';
import 'package:bps_portal_marketing/infrastructure/navigation/bindings/controllers/visit.controller.binding.dart';
import 'package:bps_portal_marketing/presentation/home/home.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/address/new.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/contact.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/contact/detail.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/contact/new.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/follow_up/follow_up.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/follow_up/new.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/sales/sales.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/telemarketing.screen.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/type/new.screen.dart';
import 'package:bps_portal_marketing/presentation/login/login.screen.dart';
import 'package:bps_portal_marketing/presentation/onboarding/onboarding.screen.dart';
import 'package:bps_portal_marketing/presentation/profile/profile.screen.dart';
import 'package:bps_portal_marketing/presentation/register/register.screen.dart';
import 'package:bps_portal_marketing/presentation/visit/camera/camera.screen.dart';
import 'package:bps_portal_marketing/presentation/visit/camera/gallery.screen.dart';
import 'package:bps_portal_marketing/presentation/visit/new.screen.dart';
import 'package:bps_portal_marketing/presentation/visit/visit.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  const EnvironmentsBadge({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()["env"];
    return env != Environments.PRODUCTION
        ? Banner(
            message: env!,
            location: BannerLocation.topStart,
            color: env == Environments.STAGING ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnBoardingScreen(),
      binding: OnBoardingControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterScreen(),
      binding: RegisterControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.VISIT,
      page: () => const VisitScreen(),
      binding: VisitControllerBinding(),
    ),
    GetPage(
      name: Routes.VISIT_CAMERA,
      page: () => const CameraScreen(),
      binding: CameraControllerBinding(),
    ),
    GetPage(
      name: Routes.TELEMARKETING,
      page: () => const TelemarketingScreen(),
      binding: TelemarketingControllerBinding(),
    ),
    GetPage(
      name: Routes.CONTACT,
      page: () => const ContactScreen(),
      binding: ContactControllerBinding(),
    ),
    GetPage(
      name: Routes.FOLLOW_UP,
      page: () => const FollowUpScreen(),
      binding: FollowUpControllerBinding(),
    ),
    GetPage(
      name: Routes.FOLLOW_UP_NEW,
      page: () => const FollowUpNewScreen(),
      binding: FollowUpControllerBinding(),
    ),
    GetPage(
      name: Routes.TELEMARKETING_ADD_TYPE,
      page: () => const NewTypeScreen(),
      binding: TypeControllerBinding(),
    ),
    GetPage(
      name: Routes.TELEMARKETING_ADD_CONTACT,
      page: () => const NewContactScreen(),
      binding: ContactControllerBinding(),
    ),
    GetPage(
      name: Routes.TELEMARKETING_DETAIL_CONTACT,
      page: () => const ContactDetailScreen(),
      binding: ContactControllerBinding(),
    ),
    GetPage(
      name: Routes.TELEMARKETING_ADD_ADDRESS,
      page: () => const NewAddressScreen(),
      binding: AddressControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileControllerBinding(),
    ),
    GetPage(
      name: Routes.SALES,
      page: () => const SalesInvoiceScreen(),
      binding: SalesInvoiceControllerBinding(),
    ),
    GetPage(
      name: Routes.SALES_NEW_VISIT,
      page: () => const NewVisitScreen(),
      binding: VisitControllerBinding(),
    ),
    GetPage(
      name: Routes.SALES_CAMERA,
      page: () => const CameraScreen(),
      binding: CameraControllerBinding(),
    ),
    GetPage(
      name: Routes.SALES_GALLERY,
      page: () => const GalleryScreen(),
      binding: CameraControllerBinding(),
    ),
  ];
}
