import 'package:bps_portal_marketing/presentation/home/controllers/telemarketing_dashboard.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';

class TelemarketingDashboardScreen
    extends GetView<TelemarketingDashboardController> {
  const TelemarketingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutralWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.neutralWhite,
        foregroundColor: Pallet.neutral700,
        centerTitle: true,
        title: Text(
          'app-name-text'.tr,
          style: TextStyles.title3,
        ),
        leading: IconButton(
          tooltip: "change-lang-text".tr,
          onPressed: () => Get.updateLocale(Get.locale == const Locale('id')
              ? const Locale('en')
              : const Locale('id')),
          icon: const Icon(Iconsax.language_circle),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "user-profile-text".tr,
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: const Icon(Iconsax.user),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.countContact(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: EdgeInsets.all(AppDimension.style20),
                crossAxisSpacing: AppDimension.style10,
                mainAxisSpacing: AppDimension.style10,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      var result = await Get.toNamed(Routes.CONTACT);
                      if (result != null) {
                        controller.countContact();
                      }
                    },
                    child: Card(
                      color: Pallet.purple[200],
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimension.style28),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppDimension.style20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'contact-text'.tr,
                                  style: TextStyles.regularNormalBold,
                                ),
                                Obx(
                                  () => Text(
                                    controller.isLoading.isTrue
                                        ? '...'
                                        : controller.contacts.toString(),
                                    style: TextStyles.largeNoneBold.copyWith(
                                      color: Pallet.purple[400],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Iconsax.people5,
                                    color: Pallet.purple[400],
                                    size: AppDimension.style50,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var result = await Get.toNamed(
                        Routes.FOLLOW_UP,
                        arguments: {'id': controller.profile?.id},
                      );
                      if (result != null) {
                        controller.countContact();
                      }
                    },
                    child: Card(
                      color: Pallet.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimension.style28),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppDimension.style20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'follow-up-text'.tr,
                                  style: TextStyles.regularNormalBold.copyWith(
                                    color: Pallet.neutralWhite,
                                  ),
                                ),
                                Text(
                                  'customer-text'.tr,
                                  style: TextStyles.largeNoneBold.copyWith(
                                    color: Pallet.orange,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Iconsax.call_outgoing5,
                                    color: Pallet.orange,
                                    size: AppDimension.style50,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var result = await Get.toNamed(Routes.SALES);
                      if (result != null) {
                        controller.countContact();
                      }
                    },
                    child: Card(
                      color: Pallet.purple[400],
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimension.style28),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppDimension.style20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "sales-text".tr,
                                  style: TextStyles.regularNormalBold.copyWith(
                                    color: Pallet.neutralWhite,
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    controller.isLoading.isTrue
                                        ? '...'
                                        : '${controller.salesInvoice?.totalCount}',
                                    style: TextStyles.largeNoneBold.copyWith(
                                      color: Pallet.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Iconsax.bag_happy,
                                    color: Pallet.neutralWhite,
                                    size: AppDimension.style50,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
