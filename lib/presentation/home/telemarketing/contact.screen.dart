import 'dart:math' as math;

import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_response.dart';
import 'package:bps_portal_marketing/presentation/home/controllers/contact.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../domain/core/network/api_url.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../../infrastructure/utils/extension/extension.dart';
import '../../../infrastructure/utils/resources/enums.dart';
import '../../../infrastructure/widgets/widgets.dart';

class ContactScreen extends GetView<ContactController> {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutral200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.purple,
        foregroundColor: Pallet.neutralWhite,
        title: Text(
          'app-name-text'.tr,
          style: TextStyles.title3.copyWith(color: Pallet.neutralWhite),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(result: ApiUrl.getContact),
          icon: const Icon(Icons.arrow_back_outlined),
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
        onRefresh: () async => controller.pagingController.refresh(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 0,
              color: Pallet.purple,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppDimension.style20),
                  bottomRight: Radius.circular(AppDimension.style20),
                ),
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppDimension.style20,
                  vertical: AppDimension.style10,
                ),
                title: CustomTextInput(
                  validator: controller.keyword,
                  isNeedClear: false,
                  isNeedSearch: true,
                  hideCaption: true,
                  filledColor: true,
                  hint: 'find-customer-text'.tr,
                  onChanged: (value) {},
                  onFieldSubmitted: (value) =>
                      controller.pagingController.refresh(),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  alignment: Alignment.center,
                  icon: Icon(
                    Iconsax.filter_search,
                    size: AppDimension.style30,
                    color: Pallet.neutralWhite,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'total-text'.trParams({'field': 'contact-text'.tr}),
                            style: TextStyles.regularNormalBold,
                          ),
                          Text(
                            controller.isLoading.isTrue
                                ? 'loading-text'.tr
                                : '${controller.contact.value.totalCount}',
                            style: TextStyles.regularNormalBold
                                .copyWith(color: Pallet.neutral600),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimension.height14),
                      Expanded(
                        child: PagedListView<int, MasterContact>(
                          pagingController: controller.pagingController,
                          builderDelegate:
                              PagedChildBuilderDelegate<MasterContact>(
                            firstPageProgressIndicatorBuilder: (context) =>
                                Center(
                              child: CircularProgressIndicator(
                                  color: Pallet.purple),
                            ),
                            newPageProgressIndicatorBuilder: (context) =>
                                Center(
                              child: Text(
                                'loading-text'.tr,
                                style: TextStyles.tinyNormalRegular
                                    .copyWith(color: Pallet.neutral600),
                              ),
                            ),
                            noItemsFoundIndicatorBuilder: (context) => Center(
                              child: Text(
                                'empty-data-text'.tr,
                                style: TextStyles.regularNormalRegular,
                              ),
                            ),
                            itemBuilder: (context, item, index) =>
                                GestureDetector(
                              onTap: () => Get.toNamed(
                                Routes.TELEMARKETING_DETAIL_CONTACT,
                                parameters: {'id': '${item.id}'},
                              ),
                              child: Card(
                                color: Pallet.neutralWhite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: AppDimension.width10,
                                        vertical: AppDimension.height4,
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor: Color(
                                                (math.Random().nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                            .withOpacity(1),
                                        child: Text(
                                          item.name.substring(0, 1),
                                          style: TextStyles.regularNormalBold
                                              .copyWith(
                                                  color: Pallet.neutralWhite),
                                        ),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              item.name,
                                              style:
                                                  TextStyles.regularNormalBold,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: AppDimension.width6,
                                              vertical: AppDimension.height2,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: item.role.toLowerCase() ==
                                                      'owner'
                                                  ? Pallet.danger600
                                                  : item.role.toLowerCase() ==
                                                          'purchasing'
                                                      ? Pallet.warning600
                                                      : item.role.toLowerCase() ==
                                                              'pegawai'
                                                          ? Pallet.info600
                                                          : Pallet.neutral600,
                                            ),
                                            child: Text(
                                              '${item.role.capitalizeFirst}',
                                              style: TextStyles
                                                  .tinyNormalRegular
                                                  .copyWith(
                                                color: Pallet.neutralWhite,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: AppDimension.width2),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: AppDimension.width6,
                                              vertical: AppDimension.height2,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: contactStatusColor[
                                                  item.status],
                                            ),
                                            child: Text(
                                              contactStatusInitial[
                                                      item.status] ??
                                                  'N/A',
                                              style: TextStyles
                                                  .tinyNormalRegular
                                                  .copyWith(
                                                color: Pallet.neutralWhite,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.phoneNumber.formatPhoneNumber,
                                            style:
                                                TextStyles.smallNormalRegular,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  '${item.group} (${item.city}, ${item.province})',
                                                  style: TextStyles
                                                      .tinyNormalBold
                                                      .copyWith(
                                                          color: Pallet
                                                              .neutral600),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                    width:
                                                        AppDimension.width10),
                                              ),
                                              item.createdByAlias != null
                                                  ? Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 7,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color:
                                                            Pallet.neutral600,
                                                      ),
                                                      child: Text(
                                                        '${item.createdByAlias?.toUpperCase()}',
                                                        style: TextStyles
                                                            .tinyNormalRegular
                                                            .copyWith(
                                                          color: Pallet
                                                              .neutralWhite,
                                                        ),
                                                      ),
                                                    )
                                                  : const Center(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    controller.keyword.controller?.value.text !=
                                            ''
                                        ? _detailWidget(item)
                                        : const Center()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.TELEMARKETING_ADD_CONTACT),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000),
        ),
        child: SpeedDial(
          backgroundColor: Pallet.purple,
          foregroundColor: Pallet.neutralWhite,
          overlayColor: Pallet.neutral600,
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 10,
          children: <SpeedDialChild>[
            SpeedDialChild(
              elevation: 0,
              backgroundColor: Pallet.purple,
              label: 'add-group-text'.tr,
              labelStyle: TextStyles.tinyNormalRegular,
              onTap: () async {
                var result = await Get.toNamed(Routes.TELEMARKETING_ADD_TYPE);
                if (result != null) {
                  controller.pagingController.refresh();
                }
              },
              child: Icon(
                Iconsax.people,
                size: AppDimension.height20,
                color: Pallet.neutralWhite,
              ),
            ),
            SpeedDialChild(
              elevation: 0,
              backgroundColor: Pallet.purple,
              label: 'add-contact-text'.tr,
              labelStyle: TextStyles.tinyNormalRegular,
              onTap: () async {
                var result =
                    await Get.toNamed(Routes.TELEMARKETING_ADD_CONTACT);
                if (result != null) {
                  controller.pagingController.refresh();
                }
              },
              child: Icon(
                Iconsax.personalcard,
                size: AppDimension.style20,
                color: Pallet.neutralWhite,
              ),
            ),
            SpeedDialChild(
              elevation: 0,
              backgroundColor: Pallet.purple,
              label: 'add-address-text'.tr,
              labelStyle: TextStyles.tinyNormalRegular,
              onTap: () async {
                var result =
                    await Get.toNamed(Routes.TELEMARKETING_ADD_ADDRESS);
                if (result != null) {
                  controller.pagingController.refresh();
                }
              },
              child: Icon(
                Iconsax.map_1,
                size: AppDimension.style20,
                color: Pallet.neutralWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _detailWidget(MasterContact item) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimension.width10,
        right: AppDimension.width10,
        bottom: AppDimension.width10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Get.closeAllSnackbars();
              Get.showSnackbar(GetSnackBar(
                backgroundColor: Pallet.neutral600,
                duration: const Duration(milliseconds: 1500),
                messageText: Text(
                  'coming-soon-text'.tr,
                  style: TextStyles.regularNormalRegular.copyWith(
                    color: Pallet.neutralWhite,
                  ),
                ),
              ));
            },
            child: Card(
              color: Pallet.neutral200,
              child: Padding(
                padding: EdgeInsets.all(AppDimension.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'latest-purchase-text'.tr,
                          style: TextStyles.regularNormalBold,
                        ),
                        Text(
                          '${item.salesInvoices?.length ?? 0}',
                          style: TextStyles.regularNormalBold,
                        ),
                      ],
                    ),
                    item.salesInvoices != null && item.salesInvoices!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: AppDimension.height10),
                              ...Iterable.generate(
                                item.salesInvoices?.length ?? 0,
                                (index) {
                                  var invoice =
                                      item.salesInvoices?.elementAt(index);
                                  int total = 0;
                                  return Card(
                                    color: Pallet.neutralWhite,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(AppDimension.width10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            invoice!.date.toIdDate,
                                            style: TextStyles.smallNormalBold,
                                          ),
                                          Text(
                                            invoice.invoiceNo,
                                            style: TextStyles.smallNormalBold,
                                          ),
                                          Divider(
                                            color: Pallet.neutral200,
                                            height: AppDimension.height10,
                                          ),
                                          ...Iterable.generate(
                                            invoice.items.length,
                                            (i) {
                                              var item =
                                                  invoice.items.elementAt(i);
                                              total += ((item.price ?? 0) *
                                                  item.qty);
                                              return Text(
                                                '${i + 1}) ${item.qty}x ${item.itemName} (@${(item.price ?? 0).toRupiah} ≈ ${((item.price ?? 0) * item.qty).toRupiah})',
                                                style: TextStyles
                                                    .smallNormalRegular,
                                              );
                                            },
                                          ),
                                          Divider(
                                            color: Pallet.neutral200,
                                            height: AppDimension.height10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  'total-text'.trParams({
                                                    'field': 'purchase-text'.tr
                                                  }),
                                                  style: TextStyles
                                                      .smallNormalBold,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  total.toRupiah,
                                                  style: TextStyles
                                                      .smallNormalBold,
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : const Center(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimension.height4),
          GestureDetector(
            onTap: () {
              Get.closeAllSnackbars();
              Get.showSnackbar(GetSnackBar(
                backgroundColor: Pallet.neutral600,
                duration: const Duration(milliseconds: 1500),
                messageText: Text(
                  'coming-soon-text'.tr,
                  style: TextStyles.regularNormalRegular.copyWith(
                    color: Pallet.neutralWhite,
                  ),
                ),
              ));
            },
            child: Card(
              color: Pallet.neutral200,
              child: Padding(
                padding: EdgeInsets.all(AppDimension.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'latest-follow-up-text'.tr,
                          style: TextStyles.regularNormalBold,
                        ),
                        Text(
                          '${item.followUps?.length ?? 0}',
                          style: TextStyles.regularNormalBold,
                        ),
                      ],
                    ),
                    item.followUps != null && item.followUps!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: AppDimension.height10),
                              ...Iterable.generate(
                                item.followUps?.length ?? 0,
                                (index) {
                                  var followUp =
                                      item.followUps?.elementAt(index);
                                  return Card(
                                    color: Pallet.neutralWhite,
                                    child: Container(
                                      width: Get.width,
                                      padding:
                                          EdgeInsets.all(AppDimension.width10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                followUp!.date.toIdDate,
                                                style:
                                                    TextStyles.smallNormalBold,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: AppDimension.height2),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: contactStatusColor[
                                                      followUp.status],
                                                ),
                                                child: Text(
                                                  contactStatusInitial[
                                                          followUp.status] ??
                                                      'N/A',
                                                  style: TextStyles
                                                      .tinyNormalRegular
                                                      .copyWith(
                                                    color: Pallet.neutralWhite,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            followUp.marketing,
                                            style: TextStyles.smallNormalBold,
                                          ),
                                          Divider(
                                            color: Pallet.neutral200,
                                            height: AppDimension.height10,
                                          ),
                                          Text(
                                            followUp.response,
                                            style:
                                                TextStyles.smallNormalRegular,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : const Center(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
