import 'package:bps_portal_marketing/presentation/profile/controllers/profile.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/dal/services/auth_service.dart';
import '../../infrastructure/theme/theme.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutralWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.info700,
        foregroundColor: Pallet.neutralWhite,
        title: Text(
          'app-name-text'.tr,
          style: TextStyles.title3.copyWith(color: Pallet.neutralWhite),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: Pallet.info700,
        onRefresh: () async => controller.getProfile(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: const BoxDecoration(
                    color: Pallet.info700,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Pallet.info100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Iconsax.user,
                          color: Pallet.info700,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          controller.isLoading.isTrue
                              ? '...'
                              : controller.profile!.username,
                          style: TextStyles.largeNormalBold
                              .copyWith(color: Pallet.neutralWhite),
                        ),
                      ),
                      Text(
                        controller.isLoading.isTrue
                            ? '...'
                            : controller.profile!.phoneNumber,
                        style: TextStyles.regularNormalRegular
                            .copyWith(color: Pallet.neutral300),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: ListTile(
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Pallet.info50,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Pallet.info100,
                      ),
                      child: const Icon(
                        Iconsax.unlock,
                        color: Pallet.info700,
                      ),
                    ),
                    trailing: const Icon(
                      Iconsax.arrow_circle_right,
                      color: Pallet.info700,
                    ),
                    title: Text(
                      'Password',
                      style: TextStyles.regularNormalRegular,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: ListTile(
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Pallet.info50,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Pallet.info100,
                      ),
                      child: const Icon(
                        Iconsax.sms,
                        color: Pallet.info700,
                      ),
                    ),
                    trailing: const Icon(
                      Iconsax.arrow_circle_right,
                      color: Pallet.info700,
                    ),
                    title: Text(
                      'Email Address',
                      style: TextStyles.regularNormalRegular,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: ListTile(
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Pallet.info50,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Pallet.info100,
                      ),
                      child: const Icon(
                        Iconsax.finger_scan,
                        color: Pallet.info700,
                      ),
                    ),
                    trailing: const Icon(
                      Iconsax.arrow_circle_right,
                      color: Pallet.info700,
                    ),
                    title: Text(
                      'Fingerprint',
                      style: TextStyles.regularNormalRegular,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: ListTile(
                    onTap: () => AuthService.to.logout(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Pallet.info50,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Pallet.info100,
                      ),
                      child: const Icon(
                        Iconsax.logout_1,
                        color: Pallet.info700,
                      ),
                    ),
                    title: Text(
                      'logout-text'.tr,
                      style: TextStyles.regularNormalRegular,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
