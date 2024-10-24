import 'package:bps_portal_marketing/presentation/home/controllers/telemarketing.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';

class TelemarketingScreen extends GetView<TelemarketingController> {
  const TelemarketingScreen({super.key});

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
        actions: <Widget>[
          IconButton(
            tooltip: "user-profile-text".tr,
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: const Icon(Iconsax.user),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Pallet.info700,
        onRefresh: () async => controller.getListDate(DateTime.now()),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 0,
                color: Pallet.info700,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          controller.chooseDate();
                        },
                        child: Text(
                          controller.isLoading.isTrue
                              ? '...'
                              : controller.currentDate.toIdDate,
                          style: TextStyles.largeNormalRegular
                              .copyWith(color: Pallet.neutralWhite),
                        ),
                      ),
                      SizedBox(height: AppDimension.height4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ...Iterable.generate(
                            controller.weeklyDate.length,
                            (index) => GestureDetector(
                              onTap: () {
                                final targetContext = controller.listKey
                                    .elementAt(index)
                                    .currentContext;
                                if (targetContext != null) {
                                  controller.activeKey(
                                      controller.listKey.elementAt(index));
                                  Scrollable.ensureVisible(
                                    controller.listKey
                                        .elementAt(index)
                                        .currentContext!,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    controller.weeklyDate
                                        .elementAt(index)
                                        .toIdDay
                                        .substring(0, 3),
                                    style: TextStyles.regularNormalRegular
                                        .copyWith(color: Pallet.neutralWhite),
                                  ),
                                  Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: controller.activeKey.value ==
                                                controller.listKey
                                                    .elementAt(index)
                                            ? Pallet.neutralWhite
                                            : Colors.transparent,
                                        width: 1.5,
                                      ),
                                      color: controller.selectedDate.toIdDate ==
                                              controller.weeklyDate
                                                  .elementAt(index)
                                                  .toIdDate
                                          ? Pallet.neutralWhite
                                          : Pallet.neutralWhite
                                              .withOpacity(0.2),
                                    ),
                                    margin: const EdgeInsets.only(top: 5),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '${controller.weeklyDate.elementAt(index).day}',
                                      style: controller.selectedDate.toIdDate ==
                                              controller.weeklyDate
                                                  .elementAt(index)
                                                  .toIdDate
                                          ? TextStyles.regularNormalRegular
                                          : TextStyles.regularNormalRegular
                                              .copyWith(
                                                  color: Pallet.neutralWhite),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: controller.isLoading.isTrue
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        controller: controller.scrollController,
                        child: Column(
                          children: <Widget>[
                            ...Iterable.generate(
                              controller.weeklyDate.length,
                              (index) => Padding(
                                key: controller.listKey.elementAt(index),
                                padding: EdgeInsets.only(
                                  left: 20,
                                  top: index == 0 ? 20 : 30,
                                  right: 20,
                                  bottom: index == controller.listKey.length - 1
                                      ? 30
                                      : 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            controller.weeklyDate
                                                .elementAt(index)
                                                .toIdDay
                                                .substring(0, 3)
                                                .toUpperCase(),
                                            style: TextStyles.smallNormalBold
                                                .copyWith(
                                                    color: Pallet.neutral500),
                                          ),
                                          Text(
                                            controller.weeklyDate
                                                .elementAt(index)
                                                .day
                                                .toString(),
                                            style: TextStyles.largeNormalBold,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          ...Iterable.generate(
                                            8,
                                            (index) => Card(
                                              elevation: 0,
                                              color: Pallet.info700
                                                  .withOpacity(0.2),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Available',
                                                          style: TextStyles
                                                              .regularNormalBold
                                                              .copyWith(
                                                                  color: Pallet
                                                                      .info700),
                                                        ),
                                                        Text(
                                                          '08.00 - 11.00',
                                                          style: TextStyles
                                                              .regularNormalRegular
                                                              .copyWith(
                                                                  color: Pallet
                                                                      .info700),
                                                        ),
                                                      ],
                                                    ),
                                                    const Icon(
                                                      Iconsax.calendar_1,
                                                      color: Pallet.info700,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          opacity: controller.showFab.isTrue ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: FloatingActionButton(
            backgroundColor: Pallet.info700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000),
            ),
            onPressed: () => controller.scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            ),
            child: const Icon(Iconsax.arrow_up_2, color: Pallet.neutralWhite),
          ),
        ),
      ),
    );
  }
}
