import 'package:bps_portal_marketing/domain/core/model/contact/request/create_contact_request.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_type_response.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/role_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/contact.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../domain/core/interfaces/api_response.dart';
import '../../../../../domain/core/model/base_response.dart';
import '../../../../../domain/core/model/failed_response.dart';
import '../../../../../domain/core/network/api_url.dart';
import '../../../../../infrastructure/widgets/widgets.dart';

class NewContactController extends GetxController implements ApiResponse {
  RxBool isTypeLoading = false.obs;
  RxBool isRoleLoading = false.obs;
  RxBool isLoading = false.obs;
  late final ContactProvider _provider = ContactProvider(this);
  List<ContactType> types = [];
  final PagingController<int, ContactType> pagingController =
      PagingController(firstPageKey: 1);
  List<RoleResponse> roles = [];
  final TextValidator search = TextValidator();
  final TextValidator name = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'name-text'.tr});
      }

      return null;
    },
  );
  final TextValidator phone = TextValidator(
    inputType: TextInputType.phone,
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'phone-text'.tr});
      }

      return null;
    },
  );
  final TextValidator type = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'group-text'.tr});
      }

      return null;
    },
  );
  final DropdownValidator role = DropdownValidator(
    errorMessage: (value) {
      if (value == null) {
        return 'required-field-text'.trParams({'field': 'role-text'.tr});
      }

      return null;
    },
  );

  Future<void> _fetchPage(int page) async {
    try {
      await _provider.getType(keyword: search.controller?.text, page: page);
      final isLastPage = types.length < 20;
      if (isLastPage) {
        pagingController.appendLastPage(types);
      } else {
        final nextPage = page + 1;
        pagingController.appendPage(types, nextPage);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  createContact() {
    if ((type.key.currentState?.validate() ?? false) &&
        (name.key.currentState?.validate() ?? false) &&
        (phone.key.currentState?.validate() ?? false) &&
        (role.key.currentState?.validate() ?? false)) {
      isLoading(true);

      _provider.createContact(
        request: CreateContactRequest(
          idContactType: type.value?.id,
          fullName: name.controller!.text,
          phoneNumber: phone.controller!.text,
          idMasterContactRole: role.value?.id,
        ),
      );
    }
  }

  @override
  void onInit() {
    _provider.getRole();
    pagingController.addPageRequestListener((page) {
      _fetchPage(page);
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
      case ApiUrl.getContactType:
        isTypeLoading(false);
        break;
      case ApiUrl.masterContactRole:
        isRoleLoading(false);
        break;
      case ApiUrl.createContact:
        isLoading(false);
        break;
      default:
        break;
    }
  }

  @override
  void onStartRequest(String path) {
    switch (path) {
      case ApiUrl.getContactType:
        isTypeLoading(true);
        break;
      case ApiUrl.masterContactRole:
        isRoleLoading(true);
        break;
      case ApiUrl.createContact:
        isRoleLoading(true);
        break;
      default:
        break;
    }
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.getContactType:
        var data = response.data as ContactTypeResponse;
        types = data.types;
        break;
      case ApiUrl.masterContactRole:
        roles = response.data;
        break;
      case ApiUrl.createContact:
        ConfirmationDialog(
          context: Get.context!,
          title: 'success-text'.tr,
          subTitle: '${response.data}\n${'add-another-question-text'.tr}',
          okLabel: 'ok-text'.tr,
          cancelLabel: 'no-text'.tr,
          onBackPressed: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.back(result: ApiUrl.createContactType);
          },
          onPressed: () {
            type.value = null;
            type.controller?.clear();
            name.controller?.clear();
            phone.controller?.clear();
            role.value = null;
            role.controller?.clear();

            Navigator.of(Get.overlayContext!).pop();
          },
        );
        break;
      default:
        break;
    }
  }
}
