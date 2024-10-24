import 'package:bps_portal_marketing/domain/core/model/sales_invoice/response/sales_invoice_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/sales.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../domain/core/interfaces/api_response.dart';
import '../../../../../domain/core/model/base_response.dart';
import '../../../../../domain/core/model/failed_response.dart';
import '../../../../../domain/core/network/api_url.dart';
import '../../../../../infrastructure/theme/theme.dart';
import '../../../../../infrastructure/utils/resources/enums.dart';
import '../../../../../infrastructure/widgets/widgets.dart';

class SalesInvoiceController extends GetxController implements ApiResponse {
  late final SalesProvider _provider = SalesProvider(this);

  RxBool isLoading = true.obs;
  final PagingController<int, SalesInvoice> pagingController =
      PagingController(firstPageKey: 1);
  Rx<SalesInvoiceResponse> salesInvoice = SalesInvoiceResponse(
    salesInvoices: [],
    count: 0,
    totalCount: 0,
  ).obs;
  RxList<SalesInvoice> salesInvoices = <SalesInvoice>[].obs;
  final Map<String, Color> brandColors = {
    'bps': Pallet.info700,
    'inf': Pallet.orange,
    'ill': Pallet.primary500,
    'pri': Pallet.info500,
  };
  final TextValidator keyword = TextValidator(
    inputAction: TextInputAction.search,
  );
  Rx<FilterDateEnum> selectedDate = FilterDateEnum.last7days.obs;
  Rx<DateTimeRange> date = DateTimeRange(
    start: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 7,
    ),
    end: DateTime.now(),
  ).obs;

  Future<void> _fetchData(int page) async {
    try {
      await _provider.getSalesInvoice(
        keyword: keyword.controller?.text,
        between: '${date.value.start.toDate}&${date.value.end.toDate}',
        page: page,
      );
      final isLastPage = salesInvoices.length < 20;
      if (isLastPage) {
        pagingController.appendLastPage(salesInvoices);
      } else {
        final nextPage = page + 1;
        pagingController.appendPage(salesInvoices, nextPage);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  chooseDate(FilterDateEnum param) async {
    selectedDate(param);

    if (param == FilterDateEnum.custom) {
      DateTimeRange? picked = await showDateRangePicker(
        context: Get.context!,
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        initialDateRange: date.value,
      );
      if (picked != null && picked != date.value) {
        date(picked);
        Get.back();
      }
    } else {
      switch (param) {
        case FilterDateEnum.today:
          date(DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now(),
          ));
          break;
        case FilterDateEnum.last7days:
          date(DateTimeRange(
            start: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day - 7),
            end: DateTime.now(),
          ));
          break;
        case FilterDateEnum.last30days:
          date(DateTimeRange(
            start: DateTime(DateTime.now().year, DateTime.now().month - 1),
            end: DateTime.now(),
          ));
          break;
        case FilterDateEnum.last90days:
          date(DateTimeRange(
            start: DateTime(DateTime.now().year, DateTime.now().month - 3),
            end: DateTime.now(),
          ));
          break;
        default:
      }

      Get.back();
    }
  }

  getDetail(int id) {
    isLoading(true);
    LoadingDialog();
    _provider.getSalesInvoiceDetail(id: id);
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchData(pageKey);
    });
    pagingController.addStatusListener(
      (status) {
        switch (status) {
          case PagingStatus.firstPageError:
          case PagingStatus.subsequentPageError:
            Get.showSnackbar(GetSnackBar(
              backgroundColor: Pallet.danger700,
              titleText: Text(
                'whoops-text'.tr,
                style: TextStyles.regularNormalBold
                    .copyWith(color: Pallet.neutralWhite),
              ),
              messageText: Text(
                'error-try-text'.tr,
                style: TextStyles.regularNormalRegular
                    .copyWith(color: Pallet.neutralWhite),
              ),
              mainButton: GestureDetector(
                onTap: () {
                  Get.closeAllSnackbars();
                  pagingController.retryLastFailedRequest();
                },
                child: Padding(
                  padding: EdgeInsets.all(AppDimension.style8),
                  child: Text(
                    'retry-text'.tr,
                    style: TextStyles.regularNormalBold.copyWith(
                      color: Pallet.purple,
                    ),
                  ),
                ),
              ),
            ));
            break;
          case PagingStatus.completed:
          // TODO: Handle this case.
          case PagingStatus.noItemsFound:
          // TODO: Handle this case.
          case PagingStatus.loadingFirstPage:
          // TODO: Handle this case.
          case PagingStatus.ongoing:
          // TODO: Handle this case.
        }
      },
    );
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  @override
  void onFailedRequest(String path, FailedResponse? failed) {
    AppDialog(
      isSuccess: false,
      title: 'whoops-text'.tr,
      description: failed?.data ?? 'error-text'.tr,
    );
  }

  @override
  void onFinishRequest(String path) {
    switch (path) {
      case ApiUrl.getSalesInvoiceDetail:
        Get.back();
        break;
    }
    isLoading(false);
  }

  @override
  void onStartRequest(String path) {
    isLoading(true);
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.getSalesInvoice:
        var data = response.data as SalesInvoiceResponse;
        salesInvoice(data);
        salesInvoices(data.salesInvoices);
        break;
      case ApiUrl.getSalesInvoiceDetail:
        var item = response.data as SalesInvoice;

        Get.defaultDialog(
          title: 'sales-text'.tr,
          titleStyle: TextStyles.largeNormalBold,
          backgroundColor: Pallet.neutralWhite,
          confirm: RoundedButtonWidget(
            label: 'ok-text'.tr,
            onPressed: () => Get.back(),
          ),
          content: SizedBox(
            height: Get.height * 0.55,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        color: brandColors[item.items.first.itemBrand
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
                  ListTile(
                    dense: true,
                    leading: const Icon(Iconsax.house),
                    title: Text(
                      '${item.contact?.city}, ${item.contact?.province}',
                      style: TextStyles.regularNormalBold,
                    ),
                    subtitle: Text(
                      '${item.contact?.detailAddress}, ${item.contact?.area}, ${item.contact?.suburb}',
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${stuff.qty}x',
                                    style: TextStyles.smallNormalRegular,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '@${(stuff.price ?? 0).toRupiah}',
                                    style: TextStyles.smallNormalRegular,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    ((stuff.price ?? 0) * stuff.qty).toRupiah,
                                    style: TextStyles.smallNormalRegular,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Divider(color: Pallet.neutral200),
                  ListTile(
                    dense: true,
                    title: Text(
                      'total-text'.trParams({'field': 'purchase-text'.tr}),
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
        );
        break;
    }
  }
}
