import 'dart:math';

import 'package:bps_portal_marketing/presentation/home/controllers/visit.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../infrastructure/widgets/widgets.dart';

class VisitScreen extends GetView<VisitController> {
  const VisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutralWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.neutralWhite,
        title: Text(
          'app-name-text'.tr,
          style: TextStyles.title3,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
            icon: const Icon(Iconsax.user),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.getDashboard(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Obx(
                () => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(controller.isLoading.isTrue ||
                            (controller.profile?.value?.profilePhoto == null)
                        ? 'https://picsum.photos/200'
                        : controller.profile!.value!.profilePhoto!),
                  ),
                  title: Text(
                    controller.isLoading.isTrue
                        ? '...'
                        : (controller.profile?.value?.username ?? '-'),
                    style: TextStyles.regularNormalBold,
                  ),
                  subtitle: Text(
                    controller.isLoading.isTrue
                        ? '...'
                        : (controller.profile?.value?.email ?? '-'),
                    style: TextStyles.smallNormalRegular,
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.notification),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: AppDimension.height20),
                padding: EdgeInsets.all(AppDimension.width20),
                decoration: BoxDecoration(
                  color: Pallet.neutral200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimension.width20),
                    topRight: Radius.circular(AppDimension.width20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GridView.count(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Card(
                          color: Pallet.neutralWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppDimension.width20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppDimension.style20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Obx(
                                  () => Text(
                                    controller.isLoading.isTrue
                                        ? '...'
                                        : controller.visit.value.todayVisit
                                            .toString(),
                                    style: TextStyles.largeNormalBold.copyWith(
                                        fontSize: AppDimension.style46),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  'visit(s) today',
                                  style: TextStyles.regularNormalRegular,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.SALES_NEW_VISIT),
                          child: Card(
                            color: Pallet.neutralWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimension.width20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(AppDimension.style20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '+',
                                    style: TextStyles.largeNormalRegular
                                        .copyWith(
                                            fontSize: AppDimension.style46),
                                  ),
                                  Text(
                                    'add new visit',
                                    style: TextStyles.regularNormalRegular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimension.height20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Your Activity',
                          style: TextStyles.regularNormalBold,
                        ),
                        Text(
                          'View All',
                          style: TextStyles.smallNormalRegular
                              .copyWith(color: Pallet.purple),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimension.height10),
                    Obx(
                      () => controller.isLoading.isTrue
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ...Iterable.generate(
                                  3,
                                  (index) => ListTile(
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        color: Pallet.purple[200],
                                        borderRadius: BorderRadius.circular(
                                            AppDimension.style10),
                                      ),
                                      padding:
                                          EdgeInsets.all(AppDimension.style8),
                                      margin: EdgeInsets.only(
                                          top: AppDimension.style4),
                                      child: Icon(
                                        Iconsax.login_1,
                                        color: Pallet.purple,
                                        size: AppDimension.style20,
                                      ),
                                    ),
                                    title: ShimmerLoading(
                                      width: Random().nextInt(10) + 5,
                                      height: 5,
                                      borderRadius: BorderRadius.circular(
                                          AppDimension.roundedButton),
                                    ),
                                    subtitle: ShimmerLoading(
                                      width: Random().nextInt(20) + 10,
                                      height: 3,
                                      borderRadius: BorderRadius.circular(
                                          AppDimension.roundedButton),
                                    ),
                                    trailing: ShimmerLoading(
                                      width: 10,
                                      height: 5,
                                      borderRadius: BorderRadius.circular(
                                          AppDimension.roundedButton),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount:
                                  controller.visit.value.historyVisit.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var visit = controller.visit.value.historyVisit
                                    .elementAt(index);
                                return Card(
                                  color: Pallet.neutralWhite,
                                  child: ListTile(
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        color: Pallet.purple[200],
                                        borderRadius: BorderRadius.circular(
                                            AppDimension.style10),
                                      ),
                                      padding:
                                          EdgeInsets.all(AppDimension.style8),
                                      margin: EdgeInsets.only(
                                          top: AppDimension.style4),
                                      child: Icon(
                                        Iconsax.login_1,
                                        color: Pallet.purple,
                                        size: AppDimension.style20,
                                      ),
                                    ),
                                    title: Text(
                                      visit.contactType,
                                      style: TextStyles.regularNormalBold,
                                    ),
                                    subtitle: Text(
                                      visit.visitAt.toIdDateOnly,
                                      style: TextStyles.smallNormalRegular
                                          .copyWith(color: Pallet.neutral600),
                                    ),
                                    trailing: Text(
                                      '${visit.visitAt.hour}:${visit.visitAt.minute} WIB',
                                      style: TextStyles.regularNormalBold,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.checkPermissions(),
        backgroundColor: Pallet.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimension.roundedButton),
        ),
        child: const Icon(
          Iconsax.camera,
          color: Pallet.neutralWhite,
        ),
      ),
    );
  }
}
