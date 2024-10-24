import 'dart:io';

import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_type_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_user_response.dart';
import 'package:bps_portal_marketing/domain/core/model/visit/request/create_request.dart';
import 'package:bps_portal_marketing/domain/core/providers/contact.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/master.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/visit.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../domain/core/interfaces/api_response.dart';
import '../../../domain/core/model/base_response.dart';
import '../../../domain/core/model/failed_response.dart';
import '../../../domain/core/network/api_url.dart';
import '../../../infrastructure/utils/extension/extension.dart';
import '../../../infrastructure/widgets/widgets.dart';

class NewVisitController extends GetxController implements ApiResponse {
  RxBool isLoading = false.obs;
  RxBool isTypeLoading = false.obs;
  RxBool isSalesLoading = false.obs;

  late final VisitProvider _provider = VisitProvider(this);
  late final ContactProvider _contactProvider = ContactProvider(this);
  late final MasterProvider _masterProvider = MasterProvider(this);
  RxList<ContactType> types = <ContactType>[].obs;
  final PagingController<int, ContactType> pagingController =
      PagingController(firstPageKey: 1);
  RxList<MasterUserResponse> roles = <MasterUserResponse>[].obs;

  final TextValidator search = TextValidator();

  final TextValidator idContactType = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'group-text'.tr});
      }

      return null;
    },
  );
  final TextValidator idSales1 = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'sales-1-text'.tr});
      }

      return null;
    },
  );
  final TextValidator idSales2 = TextValidator();
  final Rx<DateTime> visitDate = DateTime.now().obs;
  final TextValidator visitAt = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'visit-date-text'.tr});
      }

      return null;
    },
  );
  final Rxn<File>? proof = Rxn<File>();
  final TextValidator note = TextValidator();

  chooseDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: visitDate.value,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (picked != visitDate.value) {
      visitDate(picked);
      visitAt.controller?.text = picked.toIdDate;
    }
  }

  createVisit() {
    if ((idContactType.key.currentState?.validate() ?? false) &&
        (idSales1.key.currentState?.validate() ?? false) &&
        (visitAt.key.currentState?.validate() ?? false)) {
      isLoading(true);

      _provider.createVisit(
        request: CreateVisitRequest(
          idContactType: int.tryParse(idContactType.value) ?? 0,
          idSales1: int.tryParse(idSales1.value) ?? 0,
          idSales2: int.tryParse(idSales2.value),
          visitAt: visitAt.value,
          proof: proof?.value,
          note: note.value,
        ),
      );
    }
  }

  Future<void> _fetchPage(int page) async {
    try {
      await _contactProvider.getType(
        keyword: search.controller?.text,
        page: page,
      );
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

  @override
  void onInit() {
    _masterProvider.getContactType();
    _masterProvider.getUsers();
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
      case ApiUrl.masterUsers:
        isSalesLoading(false);
        break;
      default:
        isLoading(false);
        break;
    }
  }

  @override
  void onStartRequest(String path) {
    switch (path) {
      case ApiUrl.getContactType:
        isTypeLoading(true);
        break;
      case ApiUrl.masterUsers:
        isSalesLoading(true);
        break;
      default:
        isLoading(true);
        break;
    }
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.createVisit:
        ConfirmationDialog(
          context: Get.context!,
          title: 'success-text'.tr,
          subTitle: '${response.data}\n${'add-another-question-text'.tr}',
          okLabel: 'ok-text'.tr,
          cancelLabel: 'no-text'.tr,
          onBackPressed: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.back(result: ApiUrl.createVisit);
          },
          onPressed: () {
            idContactType.value = null;
            idContactType.controller?.text = '';
            idSales1.value = null;
            idSales1.controller?.text = '';
            idSales2.value = null;
            idSales2.controller?.text = '';
            proof!(null);
            note.value = null;
            note.controller?.text = '';

            Navigator.of(Get.overlayContext!).pop();
          },
        );
        break;
      case ApiUrl.getContactType:
        types(response.data);
        break;
    }
  }
}
