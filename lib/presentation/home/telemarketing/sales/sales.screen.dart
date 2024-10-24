import 'package:bps_portal_marketing/domain/core/model/sales_invoice/response/sales_invoice_response.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/sales/controllers/sales.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../domain/core/network/api_url.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../../../../infrastructure/utils/resources/enums.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class SalesInvoiceScreen extends GetView<SalesInvoiceController> {
  const SalesInvoiceScreen({super.key});

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
          onPressed: () => Get.back(result: ApiUrl.getSalesInvoice),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "filter-text".tr,
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
                            showModalBottomSheet(
                              context: Get.context!,
                              builder: (context) => StatefulBuilder(
                                builder: (context, setState2) => Container(
                                  decoration: BoxDecoration(
                                    color: Pallet.neutralWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(AppDimension.style20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ...Iterable.generate(
                                        FilterDateEnum.values.length,
                                        (index) => ListTile(
                                          dense: true,
                                          onTap: () {
                                            controller.chooseDate(FilterDateEnum
                                                .values
                                                .elementAt(index));
                                            setState(() {});
                                            setState2(() {});
                                          },
                                          leading: const Icon(
                                            Iconsax.calendar5,
                                            color: Pallet.neutral700,
                                          ),
                                          title: Text(
                                            '${filterDateString[FilterDateEnum.values.elementAt(index)]}',
                                            style:
                                                TextStyles.regularNormalRegular,
                                          ),
                                          trailing: controller
                                                      .selectedDate.value ==
                                                  FilterDateEnum.values
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
                              ),
                            );
                          },
                          isThreeLine: true,
                          dense: true,
                          leading: const Icon(
                            Iconsax.calendar5,
                            color: Pallet.neutral700,
                          ),
                          title: Text(
                            'date-text'.tr,
                            style: TextStyles.tinyNormalBold,
                          ),
                          subtitle: Text(
                            controller.selectedDate.value ==
                                    FilterDateEnum.custom
                                ? '${controller.date.value.start.toDate} - ${controller.date.value.end.toDate}'
                                : '${filterDateString[controller.selectedDate.value]}',
                            style: TextStyles.regularNormalRegular,
                          ),
                        ),
                        SizedBox(height: AppDimension.height24),
                        RoundedButtonWidget(
                          label: 'apply-text'.tr,
                          onPressed: () {
                            controller.pagingController.refresh();

                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                }),
              );
            },
            icon: const Icon(Iconsax.filter_search),
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
                  hint: 'find-text'.trParams({
                    'string':
                        "${'invoice-text'.tr}/${'customer-text'.tr}/${'store-text'.tr}/${'stuff-text'.tr}"
                            .toLowerCase()
                  }),
                  onChanged: (value) {},
                  onFieldSubmitted: (value) =>
                      controller.pagingController.refresh(),
                ),
              ),
            ),
            Expanded(
              child: PagedListView<int, SalesInvoice>(
                pagingController: controller.pagingController,
                padding: EdgeInsets.all(AppDimension.style20),
                builderDelegate: PagedChildBuilderDelegate<SalesInvoice>(
                  firstPageProgressIndicatorBuilder: (context) => Center(
                    child: CircularProgressIndicator(color: Pallet.purple),
                  ),
                  newPageProgressIndicatorBuilder: (context) => Center(
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
                  itemBuilder: (context, item, index) => GestureDetector(
                    onTap: () => controller.getDetail(item.id),
                    child: Card(
                      color: Pallet.neutralWhite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            dense: true,
                            title: Text(
                              item.invoiceNo,
                              style: TextStyles.regularNormalBold,
                            ),
                            subtitle: Text(
                              item.date.toIdDate,
                              style: TextStyles.smallNormalRegular.copyWith(
                                color: Pallet.neutral600,
                              ),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimension.height6,
                                vertical: AppDimension.width2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: controller.brandColors[item
                                    .items.first.itemBrand
                                    .substring(0, 3)
                                    .toLowerCase()],
                              ),
                              child: Text(
                                item.items.first.itemBrand
                                    .substring(0, 3)
                                    .toUpperCase(),
                                style: TextStyles.tinyNormalRegular.copyWith(
                                  color: Pallet.neutralWhite,
                                ),
                              ),
                            ),
                          ),
                          const Divider(color: Pallet.neutral200),
                          ListTile(
                            dense: true,
                            leading: const Icon(Iconsax.people),
                            title: Text(
                              item.dataBy1Username ?? '-',
                              style: TextStyles.regularNormalBold,
                            ),
                            subtitle: Text(
                              '${item.closingBy1Username ?? '-'}${item.closingBy2 != null ? " & ${item.closingBy2Username}" : ''}',
                              style: TextStyles.smallNormalRegular
                                  .copyWith(color: Pallet.neutral600),
                            ),
                          ),
                          const Divider(color: Pallet.neutral200),
                          ListTile(
                            dense: true,
                            leading: const Icon(Iconsax.user),
                            title: Text(
                              '${item.contact?.name}',
                              style: TextStyles.regularNormalBold,
                            ),
                            subtitle: Text(
                              '${item.contact?.phoneNumber.formatPhoneNumber}',
                              style: TextStyles.smallNormalRegular
                                  .copyWith(color: Pallet.neutral600),
                            ),
                          ),
                          const Divider(color: Pallet.neutral200),
                          ListTile(
                            dense: true,
                            leading: const Icon(Iconsax.shop),
                            title: Text(
                              '${item.contact?.group}',
                              style: TextStyles.regularNormalBold,
                            ),
                            subtitle: Text(
                              '${item.contact?.role}',
                              style: TextStyles.smallNormalRegular
                                  .copyWith(color: Pallet.neutral600),
                            ),
                          ),
                          const Divider(color: Pallet.neutral200),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ...Iterable.generate(
                                item.items.length,
                                (index) {
                                  var stuff = item.items.elementAt(index);
                                  return ListTile(
                                    dense: true,
                                    title: Text(
                                      stuff.itemName,
                                      style: TextStyles.regularNormalBold,
                                    ),
                                    subtitle: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            '${stuff.qty}x',
                                            style:
                                                TextStyles.smallNormalRegular,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            '@${(stuff.price ?? 0).toRupiah}',
                                            style:
                                                TextStyles.smallNormalRegular,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            ((stuff.price ?? 0) * stuff.qty)
                                                .toRupiah,
                                            style:
                                                TextStyles.smallNormalRegular,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              (item.totalItems ?? 0) > 3
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppDimension.width16),
                                      child: Text(
                                        'another-stuff-text'.trParams({
                                          'count':
                                              '${(item.totalItems ?? 0) - 3}',
                                        }),
                                        style: TextStyles.smallNormalRegular
                                            .copyWith(
                                          color: Pallet.purple[400],
                                        ),
                                      ),
                                    )
                                  : const Center(),
                            ],
                          ),
                          const Divider(color: Pallet.neutral200),
                          ListTile(
                            dense: true,
                            title: Text(
                              'total-text'.trParams({'field': 'sales-text'.tr}),
                              style: TextStyles.regularNormalBold,
                            ),
                            trailing: Text(
                              '${item.grandTotal?.toRupiah}',
                              style: TextStyles.regularNormalBold,
                              textAlign: TextAlign.end,
                            ),
                          ),
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
    );
  }
}
