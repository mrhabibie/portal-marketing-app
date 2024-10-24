import 'package:bps_portal_marketing/domain/core/model/contact/request/create_follow_up_request.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_brand_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/contact.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/follow_up.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/master.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../domain/core/interfaces/api_response.dart';
import '../../../../../domain/core/model/base_response.dart';
import '../../../../../domain/core/model/failed_response.dart';
import '../../../../../domain/core/network/api_url.dart';
import '../../../../../infrastructure/navigation/routes.dart';
import '../../../../../infrastructure/utils/extension/extension.dart';
import '../../../../../infrastructure/widgets/widgets.dart';

class FollowUpNewController extends GetxController implements ApiResponse {
  late final MasterProvider _masterProvider = MasterProvider(this);
  late final ContactProvider _contactProvider = ContactProvider(this);
  late final FollowUpProvider _provider = FollowUpProvider(this);

  RxBool isLoading = false.obs;
  RxBool isBrandLoading = false.obs;
  RxList<MasterBrand> brands = <MasterBrand>[].obs;
  RxList<MasterContact> contacts = <MasterContact>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  final TextValidator keyword = TextValidator();
  final PagingController<int, MasterContact> pagingController =
      PagingController(firstPageKey: 1);

  final DropdownValidator brand = DropdownValidator(
    errorMessage: (value) {
      if (value == null) {
        return 'required-field-text'.trParams({'field': 'brand-text'.tr});
      }

      return null;
    },
  );
  final DropdownValidator contact = DropdownValidator(
    errorMessage: (value) {
      if (value == null) {
        return 'required-field-text'.trParams({'field': 'customer-text'.tr});
      }

      return null;
    },
  );
  final TextValidator contactName = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'customer-text'.tr});
      }

      return null;
    },
  );
  final TextValidator date = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'date-text'.tr});
      }

      return null;
    },
  );
  final DropdownValidator status = DropdownValidator(
    errorMessage: (value) {
      if (value == null) {
        return 'required-field-text'.trParams({'field': 'status-text'.tr});
      }

      return null;
    },
  );
  final TextValidator response = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'response-text'.tr});
      }

      return null;
    },
  );

  Future<void> _fetchData(int page) async {
    try {
      await _contactProvider.getContacts(
          keyword: keyword.controller?.text, page: page);
      final isLastPage = contacts.length < 20;
      if (isLastPage) {
        pagingController.appendLastPage(contacts);
      } else {
        final nextPage = page + 1;
        pagingController.appendPage(contacts, nextPage);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  chooseDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (picked != selectedDate.value) {
      selectedDate(picked);
      date.controller?.text = picked.toIdDate;
    }
  }

  createResponse() {
    isLoading(true);

    if ((brand.key.currentState?.validate() ?? false) &&
        (contactName.key.currentState?.validate() ?? false) &&
        (date.key.currentState?.validate() ?? false) &&
        (response.key.currentState?.validate() ?? false) &&
        (status.key.currentState?.validate() ?? false)) {
      _provider.createFollowUp(
        request: CreateFollowUpRequest(
          idMasterBrand: brand.value?.id,
          idContact: contact.value?.id,
          response: response.controller?.text ?? '-',
          status: status.value,
          date: selectedDate.value,
        ),
      );
    }
  }

  @override
  void onInit() {
    _masterProvider.getBrand();
    pagingController.addPageRequestListener((pageKey) {
      _fetchData(pageKey);
    });
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
      case ApiUrl.masterBrands:
        isBrandLoading(false);
        break;
      default:
    }
  }

  @override
  void onStartRequest(String path) {
    switch (path) {
      case ApiUrl.masterBrands:
        isBrandLoading(true);
        break;
      case ApiUrl.createFollowUp:
        isLoading(true);
        break;
      default:
    }
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.masterBrands:
        brands(response.data);
        break;
      case ApiUrl.getContact:
        var data = response.data as ContactResponse;
        contacts(data.contacts);
        break;
      case ApiUrl.createFollowUp:
        isLoading(false);
        AppDialog(
          isSuccess: true,
          title: 'success-text'.tr,
          description: response.data,
          onDone: () {
            Get.back();
            Get.back(result: Routes.FOLLOW_UP);
          },
        );
        break;
      default:
    }
  }
}
