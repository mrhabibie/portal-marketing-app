import 'package:bps_portal_marketing/domain/core/model/contact/request/create_contact_address_request.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_type_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_addresses_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/contact.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/master.provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../domain/core/interfaces/api_response.dart';
import '../../../../../domain/core/model/base_response.dart';
import '../../../../../domain/core/model/failed_response.dart';
import '../../../../../domain/core/network/api_url.dart';
import '../../../../../infrastructure/widgets/widgets.dart';

class NewAddressController extends GetxController implements ApiResponse {
  RxBool isLoading = false.obs;
  RxBool isTypeLoading = false.obs;
  late final ContactProvider _provider = ContactProvider(this);
  late final MasterProvider _masterProvider = MasterProvider(this);
  final PagingController<int, ContactType> pagingGroupController =
      PagingController(firstPageKey: 1);
  final PagingController<int, MasterAddress> pagingCityController =
      PagingController(firstPageKey: 1);
  RxList<ContactType> types = <ContactType>[].obs;
  RxList<MasterAddress> addresses = <MasterAddress>[].obs;
  TextValidator searchGroup = TextValidator();
  TextValidator searchCity = TextValidator();
  final TextValidator type = TextValidator(
    errorMessage: (value) {
      if (value == null) {
        return 'required-field-text'.trParams({'field': 'group-text'.tr});
      }

      return null;
    },
  );
  TextValidator name = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'name-text'.tr});
      }

      return null;
    },
  );
  TextValidator phone = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'phone-text'.tr});
      }

      return null;
    },
    inputType: TextInputType.phone,
  );
  final TextValidator city = TextValidator(
    errorMessage: (value) {
      if (value == null) {
        return 'required-field-text'.trParams({'field': 'city-text'.tr});
      }

      return null;
    },
  );
  TextValidator address = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'address-text'.tr});
      }

      return null;
    },
    inputType: TextInputType.streetAddress,
  );

  createAddress() {
    if ((type.key.currentState?.validate() ?? false) &&
        (name.key.currentState?.validate() ?? false) &&
        (phone.key.currentState?.validate() ?? false) &&
        (city.key.currentState?.validate() ?? false) &&
        (address.key.currentState?.validate() ?? false)) {
      isLoading(true);

      _provider.createAddress(
        request: CreateContactAddressRequest(
          idContactType: type.value?.id,
          fullName: name.controller!.text,
          phoneNumber: phone.controller!.text,
          address: address.controller!.text,
          idMasterProvince: city.value?.provinceId,
          idMasterCity: city.value?.cityId,
          idMasterSuburb: city.value?.suburbId,
          idMasterArea: city.value?.areaId,
        ),
      );
    }
  }

  Future<void> _fetchGroups(int page) async {
    try {
      await _provider.getType(
          keyword: searchGroup.controller?.text, page: page);
      final isLastPage = types.length < 20;
      if (isLastPage) {
        pagingGroupController.appendLastPage(types);
      } else {
        final nextPage = page + 1;
        pagingGroupController.appendPage(types, nextPage);
      }
    } catch (error) {
      pagingGroupController.error = error;
    }
  }

  Future<void> _fetchCities(int page) async {
    try {
      await _masterProvider.getFullAddresses(
          keyword: searchCity.controller?.text, page: page);
      final isLastPage = addresses.length < 20;
      if (isLastPage) {
        pagingCityController.appendLastPage(addresses);
      } else {
        final nextPage = page + 1;
        pagingCityController.appendPage(addresses, nextPage);
      }
    } catch (error) {
      pagingCityController.error = error;
    }
  }

  @override
  void onInit() {
    pagingGroupController.addPageRequestListener((page) {
      _fetchGroups(page);
    });
    pagingCityController.addPageRequestListener((page) {
      _fetchCities(page);
    });
    super.onInit();
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
      case ApiUrl.createContactAddress:
        isLoading(false);
        break;
      default:
        break;
    }
  }

  @override
  void onStartRequest(String path) {
    switch (path) {
      case ApiUrl.createContactAddress:
        isLoading(true);
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
        types(data.types);
        break;
      case ApiUrl.masterFullAddresses:
        var data = response.data as MasterAddressesResponse;
        addresses(data.addresses);
        break;
      case ApiUrl.createContactAddress:
        ConfirmationDialog(
          context: Get.context!,
          title: 'success-text'.tr,
          subTitle: '${response.data}\n${'add-another-question-text'.tr}',
          okLabel: 'ok-text'.tr,
          cancelLabel: 'no-text'.tr,
          onBackPressed: () {
            Get.back();
            Get.back(result: ApiUrl.createContactType);
          },
          onPressed: () {
            type.value = null;
            type.controller?.clear();
            name.controller?.clear();
            phone.controller?.clear();
            city.value = null;
            city.controller?.clear();
            address.controller?.clear();

            Get.back();
          },
        );
        break;
      default:
        break;
    }
  }
}
