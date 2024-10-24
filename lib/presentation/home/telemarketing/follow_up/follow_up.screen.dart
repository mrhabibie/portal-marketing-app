import 'package:bps_portal_marketing/domain/core/model/contact/response/follow_up_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_response.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/follow_up/controllers/follow_up.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class FollowUpScreen extends GetView<FollowUpController> {
  const FollowUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Pallet.neutral200,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Pallet.neutral200,
          foregroundColor: Pallet.neutral700,
          centerTitle: true,
          title: Text(
            'app-name-text'.tr,
            style: TextStyles.title3,
          ),
          actions: <Widget>[
            Obx(
              () => IconButton(
                onPressed: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) =>
                        StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Iconsax.filter5,
                              color: Pallet.neutral700,
                            ),
                            SizedBox(width: AppDimension.width14),
                            Text(
                              'filter-text'.tr,
                              style: TextStyles.largeNormalBold,
                            ),
                          ],
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              onTap: () {
                                setState(() {
                                  var current = controller.createdBy.value;
                                  controller.createdBy(
                                      current == FollowUpFilterCreatedBy.all
                                          ? FollowUpFilterCreatedBy.mine
                                          : FollowUpFilterCreatedBy.all);
                                });
                              },
                              dense: true,
                              leading: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: null,
                                icon: Icon(
                                  controller.createdBy.value ==
                                          FollowUpFilterCreatedBy.all
                                      ? Icons.check_box_rounded
                                      : Icons.check_box_outline_blank_rounded,
                                  color: controller.createdBy.value ==
                                          FollowUpFilterCreatedBy.all
                                      ? Pallet.purple
                                      : Pallet.neutral700,
                                ),
                              ),
                              title: Text(
                                'filter-text'.tr,
                                style: TextStyles.tinyNormalBold,
                              ),
                              subtitle: Text(
                                'show-all-text'.tr,
                                style: TextStyles.regularNormalRegular,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                showModalBottomSheet(
                                  context: Get.context!,
                                  builder: (context) => Container(
                                    decoration: BoxDecoration(
                                      color: Pallet.neutralWhite,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomTextInput(
                                          validator: controller.search,
                                          hint:
                                              "find-store-contact-location-customer-text"
                                                  .tr,
                                          isNeedSearch: true,
                                          hideCaption: true,
                                          onChanged: (value) {
                                            if (value.isEmpty) {
                                              controller.customerId.value = 0;
                                              controller.customerName.value =
                                                  '';
                                              controller.pagingContactController
                                                  .refresh();
                                            }
                                          },
                                          onFieldSubmitted: (value) {
                                            if (value.isNotEmpty) {
                                              controller.pagingContactController
                                                  .refresh();
                                            }
                                          },
                                        ),
                                        SizedBox(height: AppDimension.height10),
                                        Expanded(
                                          child: PagedListView(
                                            pagingController: controller
                                                .pagingContactController,
                                            builderDelegate:
                                                PagedChildBuilderDelegate<
                                                    MasterContact>(
                                              firstPageProgressIndicatorBuilder:
                                                  (context) => const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Pallet.info700),
                                              ),
                                              newPageProgressIndicatorBuilder:
                                                  (context) => const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Pallet.info700),
                                              ),
                                              itemBuilder:
                                                  (context, item, index) =>
                                                      ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    controller
                                                        .customerId(item.id);
                                                    controller.customerName(
                                                        item.name);
                                                    controller.search.controller
                                                            ?.value =
                                                        TextEditingValue(
                                                            text: item.name);
                                                  });

                                                  Get.back();
                                                },
                                                contentPadding: EdgeInsets.zero,
                                                dense: true,
                                                leading:
                                                    const Icon(Iconsax.user),
                                                title: Text(
                                                  item.name,
                                                  style: TextStyles
                                                      .regularNormalRegular,
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      item.phoneNumber
                                                          .formatPhoneNumber,
                                                      style: TextStyles
                                                          .smallNormalRegular
                                                          .copyWith(
                                                        color:
                                                            Pallet.neutral600,
                                                      ),
                                                    ),
                                                    Text(
                                                      '(${item.role} ${item.group}) ${item.city}, ${item.province}',
                                                      style: TextStyles
                                                          .smallNormalRegular
                                                          .copyWith(
                                                        color:
                                                            Pallet.neutral600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              dense: true,
                              leading: const IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: null,
                                icon: Icon(
                                  Iconsax.people5,
                                  color: Pallet.neutral700,
                                ),
                              ),
                              title: Text(
                                'customer-text'.tr,
                                style: TextStyles.tinyNormalBold,
                              ),
                              subtitle: Text(
                                controller.customerId.value != 0
                                    ? controller.customerName.value
                                    : 'all-customer-text'.tr,
                                style: TextStyles.regularNormalRegular,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                showModalBottomSheet(
                                  context: Get.context!,
                                  builder: (context) => Container(
                                    decoration: BoxDecoration(
                                      color: Pallet.neutralWhite,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ...Iterable.generate(
                                          FollowUpFilterDate.values.length,
                                          (index) => ListTile(
                                            onTap: () {
                                              setState(() {
                                                controller.chooseDate(
                                                    FollowUpFilterDate.values
                                                        .elementAt(index));
                                              });
                                            },
                                            leading: const Icon(
                                              Iconsax.calendar5,
                                              color: Pallet.neutral700,
                                            ),
                                            title: Text(
                                              FollowUpFilterDate.values
                                                          .elementAt(index) ==
                                                      FollowUpFilterDate.today
                                                  ? 'today-text'.tr
                                                  : FollowUpFilterDate.values
                                                              .elementAt(
                                                                  index) ==
                                                          FollowUpFilterDate
                                                              .custom
                                                      ? 'custom-text'.tr
                                                      : '${'last-n-days-text'.trParams({
                                                              'number': controller
                                                                          .stringDays[
                                                                      FollowUpFilterDate
                                                                          .values
                                                                          .elementAt(
                                                                              index)] ??
                                                                  '0'
                                                            })}${Get.locale == const Locale('id') ? ''.toLowerCase() : ''}',
                                              style: TextStyles
                                                  .regularNormalRegular,
                                            ),
                                            trailing: controller
                                                        .selectedDate.value ==
                                                    FollowUpFilterDate.values
                                                        .elementAt(index)
                                                ? Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Pallet.orange,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              leading: const IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: null,
                                icon: Icon(
                                  Iconsax.calendar5,
                                  color: Pallet.neutral700,
                                ),
                              ),
                              title: Text(
                                'date-text'.tr,
                                style: TextStyles.tinyNormalBold,
                              ),
                              subtitle: Text(
                                controller.selectedDate.value ==
                                        FollowUpFilterDate.today
                                    ? 'today-text'.tr
                                    : controller.selectedDate.value ==
                                            FollowUpFilterDate.custom
                                        ? 'custom-text'.tr
                                        : '${'last-n-days-text'.trParams({
                                                'number': controller.stringDays[
                                                        controller.selectedDate
                                                            .value] ??
                                                    '0'
                                              })}${Get.locale == const Locale('id') ? ''.toLowerCase() : ''}',
                                style: TextStyles.regularNormalRegular,
                              ),
                            ),
                            SizedBox(height: AppDimension.height24),
                            RoundedButtonWidget(
                              label: 'apply-text'.tr,
                              onPressed: () {
                                controller.pagingController.refresh();
                                controller.pagingReminderController.refresh();

                                Get.back();
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                },
                icon: Icon(
                  (controller.createdBy.value !=
                              FollowUpFilterCreatedBy.mine) ||
                          (controller.customerId.value != 0) ||
                          (controller.date.value != '')
                      ? Iconsax.filter_tick5
                      : Iconsax.filter5,
                  color: Pallet.neutral700,
                ),
                tooltip: (controller.createdBy.value !=
                            FollowUpFilterCreatedBy.mine) ||
                        (controller.customerId.value != 0) ||
                        (controller.date.value != '')
                    ? 'filter-used-text'.tr
                    : 'filter-text'.tr,
              ),
            ),
          ],
          bottom: TabBar(
            labelStyle: TextStyles.regularNormalBold,
            indicatorColor: Pallet.purple,
            tabs: <Widget>[
              Tab(text: 'follow-up-text'.tr),
              Tab(text: 'reminder-text'.tr),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            RefreshIndicator(
              onRefresh: () async => controller.pagingController.refresh(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(AppDimension.style20),
                    child: Obx(
                      () => RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'display-text'.tr,
                              style: TextStyles.regularNormalRegular,
                            ),
                            Get.locale == const Locale('id') &&
                                    controller.createdBy.value ==
                                        FollowUpFilterCreatedBy.all
                                ? TextSpan(
                                    text: ' ${'all-text'.tr.toLowerCase()}',
                                    style: TextStyles.regularNormalBold,
                                  )
                                : const TextSpan(text: ''),
                            Get.locale == const Locale('id')
                                ? TextSpan(
                                    text: ' ${'of-data-text'.tr.toLowerCase()}',
                                    style: TextStyles.regularNormalRegular,
                                  )
                                : const TextSpan(text: ''),
                            Get.locale == const Locale('en')
                                ? const TextSpan(text: '')
                                : TextSpan(
                                    text: controller.selectedDate.value ==
                                                FollowUpFilterDate.custom ||
                                            controller.selectedDate.value ==
                                                FollowUpFilterDate.today
                                        ? ' ${'latest-text'.tr.toLowerCase()}'
                                        : ' ${'last-n-days-text'.trParams({
                                                'number': controller.stringDays[
                                                        controller.selectedDate
                                                            .value] ??
                                                    '0'
                                              }).toLowerCase()}',
                                    style: TextStyles.regularNormalBold,
                                  ),
                            Get.locale == const Locale('id') &&
                                    controller.createdBy.value ==
                                        FollowUpFilterCreatedBy.all
                                ? const TextSpan(text: '')
                                : TextSpan(
                                    text: controller.createdBy.value ==
                                            FollowUpFilterCreatedBy.mine
                                        ? ' ${'your-text'.tr.toLowerCase()}'
                                        : ' ${'all-text'.tr.toLowerCase()}',
                                    style: TextStyles.regularNormalBold,
                                  ),
                            Get.locale == const Locale('id')
                                ? const TextSpan(text: '')
                                : TextSpan(
                                    text: controller.selectedDate.value ==
                                                FollowUpFilterDate.custom ||
                                            controller.selectedDate.value ==
                                                FollowUpFilterDate.today
                                        ? ' ${'latest-text'.tr.toLowerCase()}'
                                        : ' ${'last-n-days-text'.trParams({
                                                'number': controller.stringDays[
                                                        controller.selectedDate
                                                            .value] ??
                                                    '0'
                                              }).toLowerCase()}',
                                    style: TextStyles.regularNormalBold,
                                  ),
                            Get.locale == const Locale('en')
                                ? TextSpan(
                                    text: ' ${'of-data-text'.tr.toLowerCase()}',
                                    style: TextStyles.regularNormalRegular,
                                  )
                                : const TextSpan(text: ''),
                            TextSpan(
                              text: controller.customerId.value != 0
                                  ? ' ${'that-contains-text'.tr.toLowerCase()}'
                                  : '',
                              style: TextStyles.regularNormalRegular,
                            ),
                            TextSpan(
                              text: controller.customerId.value != 0
                                  ? ' ${controller.customerName.value}'
                                  : '',
                              style: TextStyles.regularNormalBold,
                            ),
                            TextSpan(
                              text: '.',
                              style: TextStyles.regularNormalRegular,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PagedListView(
                      pagingController: controller.pagingController,
                      padding: EdgeInsets.only(
                        left: AppDimension.style20,
                        right: AppDimension.style20,
                        bottom: AppDimension.style20,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<ListFollowUp>(
                        noItemsFoundIndicatorBuilder: (context) => Center(
                          child: Text(
                            'empty-data-text'.tr,
                            style: TextStyles.regularNormalRegular,
                          ),
                        ),
                        firstPageProgressIndicatorBuilder: (context) => Center(
                          child:
                              CircularProgressIndicator(color: Pallet.purple),
                        ),
                        itemBuilder: (context, item, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: AppDimension.height10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Iconsax.calendar5,
                                    size: AppDimension.style24,
                                    color: Pallet.orange,
                                  ),
                                  SizedBox(width: AppDimension.width4),
                                  Text(
                                    item.date.toIdDate,
                                    style: TextStyles.largeNormalBold,
                                  ),
                                ],
                              ),
                            ),
                            ...Iterable.generate(
                              item.data.length,
                              (i) {
                                var data = item.data.elementAt(i);

                                return Card(
                                  color: Pallet.neutralWhite,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(AppDimension.width20),
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              data.marketing,
                                              style: TextStyles.largeNormalBold,
                                            ),
                                            Text(
                                              'follow-up-count-text'.trParams({
                                                'number': data.customersCount
                                                    .toString(),
                                              }),
                                              style: TextStyles.smallNormalBold
                                                  .copyWith(
                                                color: Pallet.neutral600,
                                              ),
                                            ),
                                            const Divider(
                                              color: Pallet.neutral400,
                                              thickness: 0.5,
                                            ),
                                            SizedBox(
                                                height: AppDimension.height6),
                                            ...Iterable.generate(
                                              data.customers.length,
                                              (j) => FollowUpItem(
                                                customer:
                                                    data.customers.elementAt(j),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                                height: AppDimension.height10),
                                            GestureDetector(
                                              onTap: () => controller
                                                  .getCustomers(data.id),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'see-more-text'.tr,
                                                    style: TextStyles
                                                        .regularNormalRegular
                                                        .copyWith(
                                                      color: Pallet.purple,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          AppDimension.width4),
                                                  Icon(
                                                    Icons
                                                        .keyboard_double_arrow_right_rounded,
                                                    size: AppDimension.style10,
                                                    color: Pallet.purple,
                                                  ),
                                                ],
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RefreshIndicator(
              onRefresh: () async =>
                  controller.pagingReminderController.refresh(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(AppDimension.style20),
                    child: Chip(
                      color: WidgetStateProperty.all(Pallet.orange[200]),
                      label: Text(
                        'reminder-desc-text'.tr,
                        style: TextStyles.regularNormalBold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    child: PagedListView(
                      pagingController: controller.pagingReminderController,
                      padding: EdgeInsets.only(
                        left: AppDimension.style20,
                        right: AppDimension.style20,
                        bottom: AppDimension.style20,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<ListFollowUp>(
                        noItemsFoundIndicatorBuilder: (context) => Center(
                          child: Text(
                            'empty-data-text'.tr,
                            style: TextStyles.regularNormalRegular,
                          ),
                        ),
                        firstPageProgressIndicatorBuilder: (context) => Center(
                          child:
                              CircularProgressIndicator(color: Pallet.purple),
                        ),
                        itemBuilder: (context, item, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: AppDimension.height10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_right_outlined,
                                    size: AppDimension.style24,
                                    color: Pallet.orange,
                                  ),
                                  Text(
                                    item.date.toIdDate,
                                    style: TextStyles.largeNormalBold,
                                  ),
                                ],
                              ),
                            ),
                            ...Iterable.generate(
                              item.data.length,
                              (i) {
                                var data = item.data.elementAt(i);

                                return Card(
                                  color: Pallet.neutralWhite,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(AppDimension.width20),
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              data.marketing,
                                              style: TextStyles.largeNormalBold,
                                            ),
                                            Text(
                                              'follow-up-count-text'.trParams({
                                                'number': data.customersCount
                                                    .toString(),
                                              }),
                                              style: TextStyles.smallNormalBold
                                                  .copyWith(
                                                color: Pallet.neutral600,
                                              ),
                                            ),
                                            SizedBox(
                                                height: AppDimension.height6),
                                            ...Iterable.generate(
                                              data.customers.length,
                                              (j) => FollowUpItem(
                                                  customer: data.customers
                                                      .elementAt(j)),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                                height: AppDimension.height6),
                                            GestureDetector(
                                              onTap: () =>
                                                  controller.getReminderDetail(
                                                id: data.id,
                                                idMarketing: data.idMarketing,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'see-more-text'.tr,
                                                    style: TextStyles
                                                        .regularNormalRegular
                                                        .copyWith(
                                                      color: Pallet.purple,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          AppDimension.width4),
                                                  Icon(
                                                    Icons
                                                        .keyboard_double_arrow_right_rounded,
                                                    size: AppDimension.style10,
                                                    color: Pallet.purple,
                                                  ),
                                                ],
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Pallet.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
          onPressed: () async {
            final result = await Get.toNamed(Routes.FOLLOW_UP_NEW);
            if (result != null) {
              controller.pagingController.refresh();
              controller.pagingReminderController.refresh();
            }
          },
          child: const Icon(
            Icons.add_rounded,
            color: Pallet.neutralWhite,
          ),
        ),
      ),
    );
  }
}
