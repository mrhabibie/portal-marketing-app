import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/contact.provider.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../domain/core/interfaces/api_response.dart';
import '../../../../../domain/core/model/base_response.dart';
import '../../../../../domain/core/model/failed_response.dart';
import '../../../../../domain/core/network/api_url.dart';
import '../../../../../infrastructure/widgets/widgets.dart';

class ContactDetailController extends GetxController implements ApiResponse {
  RxBool isLoading = false.obs;
  late final ContactProvider _provider = ContactProvider(this);
  MasterContact? contact;

  Future<void> launch(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      AppDialog(
        isSuccess: false,
        title: 'whoops-text'.tr,
        description: 'Couldn\'t launch ${uri.scheme}',
      );
    }
  }

  @override
  void onInit() {
    _provider.getContactDetail(
        contactId: int.tryParse(Get.parameters['id'] ?? '0') ?? 0);
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
    isLoading(false);
  }

  @override
  void onStartRequest(String path) {
    isLoading(true);
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.getContactDetail:
        contact = response.data;
        break;
      default:
        break;
    }
  }
}
