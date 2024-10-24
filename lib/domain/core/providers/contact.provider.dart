import 'package:bps_portal_marketing/domain/core/model/contact/request/create_contact_address_request.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/request/create_contact_request.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/request/create_contact_type_request.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_response.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_type_response.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/role_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_response.dart';

import '../interfaces/api_response.dart';
import '../model/base_response.dart';
import '../network/api_client.dart';
import '../network/api_url.dart';

class ContactProvider extends ApiClient {
  final ApiResponse apiResponse;

  ContactProvider(this.apiResponse) {
    super.onInit();
  }

  void getRole() async {
    String path = ApiUrl.masterContactRole;
    apiResponse.onStartRequest(path);
    var response = await get(path);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<List<RoleResponse>>(List<RoleResponse>.from(
            response.body['data'].map((json) => RoleResponse.fromJson(json)))),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  Future<void> count() async {
    String path = ApiUrl.countContact;
    apiResponse.onStartRequest(path);
    var response = await get(path);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
          path, BaseResponse<int>(response.body['data']));
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  Future<void> getContacts({String? keyword, int page = 1}) async {
    String path = ApiUrl.getContact;
    apiResponse.onStartRequest(path);
    super.params = {"keyword": keyword, "page": page.toString()};
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<ContactResponse>(
            ContactResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void getContactDetail({required int contactId}) async {
    String path = ApiUrl.getContactDetail;
    apiResponse.onStartRequest(path);
    super.params = {"id": '$contactId'};
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<MasterContact>(
            MasterContact.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void createContact({required CreateContactRequest request}) async {
    String path = ApiUrl.createContact;
    apiResponse.onStartRequest(path);
    super.body = request.toJson();
    var response = await post(path, {'data': request.toJson()});
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(path, BaseResponse(response.body['data']));
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  Future<void> getType({String? keyword, int? page}) async {
    String path = ApiUrl.getContactType;
    apiResponse.onStartRequest(path);
    super.params = {"keyword": keyword, "page": page.toString()};
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<ContactTypeResponse>(
            ContactTypeResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void createType({required CreateContactTypeRequest request}) async {
    String path = ApiUrl.createContactType;
    apiResponse.onStartRequest(path);
    super.body = request.toJson();
    var response = await post(path, {'data': request.toJson()});
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
          path, BaseResponse<String>(response.body['data']));
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void createAddress({required CreateContactAddressRequest request}) async {
    String path = ApiUrl.createContactAddress;
    apiResponse.onStartRequest(path);
    super.body = request.toJson();
    var response = await post(path, {'data': request.toJson()});
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
          path, BaseResponse<String>(response.body['data']));
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }
}
