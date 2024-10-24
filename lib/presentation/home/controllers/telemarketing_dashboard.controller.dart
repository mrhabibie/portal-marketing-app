import 'package:bps_portal_marketing/domain/core/model/login/response/login_response.dart';
import 'package:bps_portal_marketing/domain/core/model/sales_invoice/response/sales_invoice_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/contact.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/profile.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/sales.provider.dart';
import 'package:get/get.dart';

import '../../../domain/core/interfaces/api_response.dart';
import '../../../domain/core/model/base_response.dart';
import '../../../domain/core/model/failed_response.dart';
import '../../../domain/core/network/api_url.dart';
import '../../../infrastructure/widgets/widgets.dart';

class TelemarketingDashboardController extends GetxController
    implements ApiResponse {
  late final ContactProvider _contactProvider = ContactProvider(this);
  late final ProfileProvider _profileProvider = ProfileProvider(this);
  late final SalesProvider _salesProvider = SalesProvider(this);

  RxBool isLoading = false.obs;

  int contacts = 0;
  LoginResponse? profile;
  SalesInvoiceResponse? salesInvoice;

  void countContact() {
    isLoading(true);
    _contactProvider.count();
  }

  @override
  void onInit() {
    countContact();
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
      case ApiUrl.profile:
        isLoading(false);
        break;
      default:
    }
  }

  @override
  void onStartRequest(String path) {
    switch (path) {
      case ApiUrl.countContact:
        isLoading(true);
        break;
      default:
    }
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.countContact:
        contacts = response.data;

        _salesProvider.getSalesInvoice();
        break;
      case ApiUrl.getSalesInvoice:
        salesInvoice = response.data;

        _profileProvider.getProfile();
        break;
      case ApiUrl.profile:
        profile = response.data;
        break;
      default:
    }
  }
}
