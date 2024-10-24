import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/contact.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../domain/core/interfaces/api_response.dart';
import '../../../domain/core/model/base_response.dart';
import '../../../domain/core/model/failed_response.dart';
import '../../../domain/core/network/api_url.dart';
import '../../../infrastructure/widgets/widgets.dart';

class ContactController extends GetxController implements ApiResponse {
  RxBool isLoading = false.obs;
  late final ContactProvider _provider = ContactProvider(this);
  final PagingController<int, MasterContact> pagingController =
      PagingController(firstPageKey: 1);
  late Rx<ContactResponse> contact = ContactResponse(
    contacts: [],
    totalCount: 0,
  ).obs;
  RxList<MasterContact> contacts = <MasterContact>[].obs;
  final TextValidator keyword = TextValidator(
    inputAction: TextInputAction.search,
  );

  Future<void> _fetchData(int page) async {
    try {
      await _provider.getContacts(
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

  @override
  void onInit() {
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
  void onFinishRequest(String path) {}

  @override
  void onStartRequest(String path) {}

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.getContact:
        var data = response.data as ContactResponse;
        contact(data);
        contacts(data.contacts);
        break;
      default:
        break;
    }
  }
}
