import 'package:bps_portal_marketing/domain/core/model/contact/request/create_contact_type_request.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_city_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_type_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/contact.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/master.provider.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../domain/core/interfaces/api_response.dart';
import '../../../../../domain/core/model/base_response.dart';
import '../../../../../domain/core/model/failed_response.dart';
import '../../../../../domain/core/network/api_url.dart';
import '../../../../../infrastructure/widgets/widgets.dart';

class NewTypeController extends GetxController implements ApiResponse {
  late final MasterProvider _provider = MasterProvider(this);
  late final ContactProvider _contactProvider = ContactProvider(this);

  RxBool isLoading = false.obs;
  RxBool isTypeLoading = false.obs;

  final PagingController<int, MasterCity> pagingController =
      PagingController(firstPageKey: 1);

  RxList<MasterContactTypeResponse> types = <MasterContactTypeResponse>[].obs;
  RxList<MasterCity> cities = <MasterCity>[].obs;

  final TextValidator search = TextValidator();
  final TextValidator name = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'name-text'.tr});
      }

      return null;
    },
  );
  final DropdownValidator type = DropdownValidator(
    errorMessage: (value) {
      if (value == null) {
        return 'required-field-text'.trParams({'field': 'group-text'.tr});
      }

      return null;
    },
  );
  final TextValidator city = TextValidator(
    errorMessage: (value) {
      if (value == null || value.isEmpty) {
        return 'required-field-text'.trParams({'field': 'city-text'.tr});
      }

      return null;
    },
  );

  Future<void> _fetchPage(int page) async {
    try {
      await _provider.getCities(
        keyword: search.controller?.text,
        withProvince: true,
        page: page,
      );
      final isLastPage = cities.length < 20;
      if (isLastPage) {
        pagingController.appendLastPage(cities);
      } else {
        final nextPage = page + 1;
        pagingController.appendPage(cities, nextPage);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  createType() {
    if ((name.key.currentState?.validate() ?? false) &&
        (type.key.currentState?.validate() ?? false) &&
        (city.key.currentState?.validate() ?? false)) {
      isLoading(true);

      _contactProvider.createType(
        request: CreateContactTypeRequest(
          name: name.controller!.text,
          idMasterProvince: city.value?.idMasterProvince,
          idMasterCity: city.value?.id,
          idMasterContactType: type.value?.id,
        ),
      );
    }
  }

  @override
  void onInit() {
    _provider.getContactType();
    pagingController.addPageRequestListener((page) {
      _fetchPage(page);
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
      case ApiUrl.masterContactType:
        isTypeLoading(false);
        break;
      case ApiUrl.createContactType:
        isLoading(false);
        break;
      default:
    }
  }

  @override
  void onStartRequest(String path) {
    switch (path) {
      case ApiUrl.masterContactType:
        isTypeLoading(true);
        break;
      case ApiUrl.createContactType:
        isLoading(true);
        break;
      default:
    }
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.masterContactType:
        types(response.data);
        break;
      case ApiUrl.masterCities:
        var data = response.data as MasterCityResponse;
        cities(data.cities);
        break;
      case ApiUrl.createContactType:
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
            name.controller?.clear();
            type.value = null;
            type.controller?.clear();
            city.controller?.clear();

            Get.back();
          },
        );
        break;
      default:
    }
  }
}
