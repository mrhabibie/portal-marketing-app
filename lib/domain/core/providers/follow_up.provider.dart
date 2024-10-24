import 'package:bps_portal_marketing/domain/core/model/contact/request/create_follow_up_request.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/follow_up_response.dart';

import '../interfaces/api_response.dart';
import '../model/base_response.dart';
import '../network/api_client.dart';
import '../network/api_url.dart';

class FollowUpProvider extends ApiClient {
  final ApiResponse apiResponse;

  FollowUpProvider(this.apiResponse) {
    super.onInit();
  }

  /// Get list of follow up.
  Future<void> getFollowUps({
    int? createdBy,
    int? contactId,
    String? between,
    int page = 1,
  }) async {
    String path = ApiUrl.followUp;
    apiResponse.onStartRequest(path);
    super.params = {
      'created_by': createdBy?.toString(),
      'contact_id': contactId?.toString(),
      'between': between,
      'page': page.toString(),
    };
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<FollowUpResponse>(
            FollowUpResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  /// Get list of customers from specific
  /// follow-up id.
  /// For "See more" button purpose.
  Future<void> getCustomers({required int id}) async {
    String path = ApiUrl.followUpCustomers;
    apiResponse.onStartRequest(path);
    super.params = {'id': id.toString()};
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<List<Customer>>(
          List<Customer>.from(
              response.body['data'].map((x) => Customer.fromJson(x))),
        ),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  /// Get reminder details.
  /// For "See more" button purpose.
  Future<void> getReminderDetail(
      {required int id, required int idMarketing}) async {
    String path = ApiUrl.reminderDetail;
    apiResponse.onStartRequest(path);
    super.params = {
      'id': id.toString(),
      'id_marketing': idMarketing.toString(),
    };
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<List<Customer>>(
          List<Customer>.from(
              response.body['data'].map((x) => Customer.fromJson(x))),
        ),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  /// Get list of reminder.
  Future<void> getReminders({
    int? createdBy,
    int? contactId,
    int page = 1,
  }) async {
    String path = ApiUrl.reminders;
    apiResponse.onStartRequest(path);
    super.params = {
      'created_by': createdBy?.toString(),
      'contact_id': contactId?.toString(),
      'page': page.toString(),
    };
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<FollowUpResponse>(
            FollowUpResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  /// Store follow up from marketing.
  void createFollowUp({required CreateFollowUpRequest request}) async {
    String path = ApiUrl.createFollowUp;
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
}
