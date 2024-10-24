import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_response.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/follow_up_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/contact.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/follow_up.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../domain/core/interfaces/api_response.dart';
import '../../../../../domain/core/model/base_response.dart';
import '../../../../../domain/core/model/failed_response.dart';
import '../../../../../domain/core/network/api_url.dart';
import '../../../../../infrastructure/theme/theme.dart';
import '../../../../../infrastructure/widgets/widgets.dart';

enum FollowUpFilterCreatedBy { all, mine }

enum FollowUpFilterDate { today, last7days, last30days, last90days, custom }

class FollowUpController extends GetxController implements ApiResponse {
  late final FollowUpProvider _provider = FollowUpProvider(this);
  late final ContactProvider _contactProvider = ContactProvider(this);

  RxBool isLoading = false.obs;

  Rx<int> userId = 0.obs;
  Rx<FollowUpFilterCreatedBy> createdBy = FollowUpFilterCreatedBy.mine.obs;
  Rx<int> customerId = 0.obs;
  Rx<String> customerName = ''.obs;
  Rx<FollowUpFilterDate> selectedDate = FollowUpFilterDate.last7days.obs;
  Rx<DateTimeRange> date = DateTimeRange(
    start: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 7,
    ),
    end: DateTime.now(),
  ).obs;
  final TextValidator search = TextValidator();

  RxList<ListFollowUp> followUps = <ListFollowUp>[].obs;
  RxList<ListFollowUp> reminders = <ListFollowUp>[].obs;
  RxList<Customer> customers = <Customer>[].obs;
  RxList<MasterContact> contacts = <MasterContact>[].obs;
  final Map<String, Color> brandColors = {
    'bps': Pallet.info700,
    'inf': Pallet.orange,
    'ill': Pallet.primary500,
    'pri': Pallet.info500,
  };
  final Map<FollowUpFilterDate, String> stringDays = {
    FollowUpFilterDate.last7days: '7',
    FollowUpFilterDate.last30days: '30',
    FollowUpFilterDate.last90days: '90',
  };

  final PagingController<int, ListFollowUp> pagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, ListFollowUp> pagingReminderController =
      PagingController(firstPageKey: 1);
  final PagingController<int, MasterContact> pagingContactController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int page) async {
    try {
      await _provider.getFollowUps(
        createdBy:
            createdBy.value == FollowUpFilterCreatedBy.mine ? userId.value : 0,
        contactId: customerId.value,
        between: '${date.value.start.toDate}&${date.value.end.toDate}',
        page: page,
      );
      final isLastPage = followUps.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(followUps);
      } else {
        final nextPage = page + 1;
        pagingController.appendPage(followUps, nextPage);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> _fetchReminderPage(int page) async {
    try {
      await _provider.getReminders(
        createdBy:
            createdBy.value == FollowUpFilterCreatedBy.mine ? userId.value : 0,
        contactId: customerId.value,
        page: page,
      );
      final isLastPage = reminders.isEmpty;
      if (isLastPage) {
        pagingReminderController.appendLastPage(reminders);
      } else {
        final nextPage = page + 1;
        pagingReminderController.appendPage(reminders, nextPage);
      }
    } catch (error) {
      pagingReminderController.error = error;
    }
  }

  Future<void> _fetchContact(int page) async {
    try {
      await _contactProvider.getContacts(
        keyword: search.controller?.text,
        page: page,
      );
      final isLastPage = contacts.length < 20;
      if (isLastPage) {
        pagingContactController.appendLastPage(contacts);
      } else {
        final nextPage = page + 1;
        pagingContactController.appendPage(contacts, nextPage);
      }
    } catch (error) {
      pagingContactController.error = error;
    }
  }

  chooseDate(FollowUpFilterDate param) async {
    selectedDate(param);

    if (param == FollowUpFilterDate.custom) {
      DateTimeRange? picked = await showDateRangePicker(
        context: Get.context!,
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
        initialDateRange: date.value,
      );
      if (picked != null && picked != date.value) {
        date(picked);
      }
    } else {
      switch (param) {
        case FollowUpFilterDate.today:
          date(DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now(),
          ));
          break;
        case FollowUpFilterDate.last7days:
          date(DateTimeRange(
            start: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day - 7),
            end: DateTime.now(),
          ));
          break;
        case FollowUpFilterDate.last30days:
          date(DateTimeRange(
            start: DateTime(DateTime.now().year, DateTime.now().month - 1),
            end: DateTime.now(),
          ));
          break;
        case FollowUpFilterDate.last90days:
          date(DateTimeRange(
            start: DateTime(DateTime.now().year, DateTime.now().month - 3),
            end: DateTime.now(),
          ));
          break;
        default:
      }

      Navigator.of(Get.overlayContext!).pop();
    }
  }

  void getCustomers(int id) {
    isLoading(true);
    LoadingDialog();
    _provider.getCustomers(id: id);
  }

  void getReminderDetail({required int id, required int idMarketing}) {
    isLoading(true);
    LoadingDialog();
    _provider.getReminderDetail(
      id: id,
      idMarketing: idMarketing,
    );
  }

  @override
  void onInit() {
    userId(Get.arguments?['id'] ?? 0);
    pagingController.addPageRequestListener((page) {
      _fetchPage(page);
    });
    pagingReminderController.addPageRequestListener((page) {
      _fetchReminderPage(page);
    });
    pagingContactController.addPageRequestListener((page) {
      _fetchContact(page);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    pagingReminderController.dispose();
    pagingContactController.dispose();
    super.onClose();
  }

  @override
  void onFailedRequest(String path, FailedResponse? failed) {
    Navigator.of(Get.overlayContext!).pop();
    AppDialog(
      isSuccess: false,
      title: 'whoops-text'.tr,
      description: failed?.data ?? 'error-text'.tr,
    );
  }

  @override
  void onFinishRequest(String path) {
    switch (path) {
      case ApiUrl.followUpCustomers:
      case ApiUrl.reminderDetail:
        isLoading(false);
        Navigator.of(Get.overlayContext!).pop();
        break;
      case ApiUrl.followUp:
        // isLoadingReminder(false);
        break;
      default:
    }
  }

  @override
  void onStartRequest(String path) {
    switch (path) {
      case ApiUrl.followUpCustomers:
        isLoading(true);
        break;
      default:
    }
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.followUp:
        var data = response.data as FollowUpResponse;
        followUps(data.followUps);
        break;
      case ApiUrl.followUpCustomers:
      case ApiUrl.reminderDetail:
        customers(response.data);
        Get.defaultDialog(
          title: 'customer-text'.tr,
          titleStyle: TextStyles.largeNormalBold,
          confirm: RoundedButtonWidget(
            label: 'ok-text'.tr,
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          ),
          content: SizedBox(
            width: Get.width * 0.9,
            height: Get.height * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: customers.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: AppDimension.width10),
                    itemBuilder: (context, index) => FollowUpItem(
                      customer: customers.elementAt(index),
                      isDetail: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case ApiUrl.reminders:
        var data = response.data as FollowUpResponse;
        reminders(data.followUps);
        break;
      case ApiUrl.getContact:
        var data = response.data as ContactResponse;
        contacts(data.contacts);
        break;
      default:
        break;
    }
  }
}
