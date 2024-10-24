import 'package:bps_portal_marketing/domain/core/model/visit/request/create_request.dart';
import 'package:bps_portal_marketing/domain/core/model/visit/response/visit_response.dart';
import 'package:get/get.dart';

import '../interfaces/api_response.dart';
import '../model/base_response.dart';
import '../network/api_client.dart';
import '../network/api_url.dart';

class VisitProvider extends ApiClient {
  final ApiResponse apiResponse;

  VisitProvider(this.apiResponse) {
    super.onInit();
  }

  /// Get visit list.
  Future<void> getVisitDashboard() async {
    String path = ApiUrl.getVisit;
    apiResponse.onStartRequest(path);
    var response = await get(path);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<VisitResponse>(
            VisitResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  /// Create a new Visit.
  Future<void> createVisit({required CreateVisitRequest request}) async {
    String path = ApiUrl.createVisit;
    apiResponse.onStartRequest(path);
    final body = FormData({
      'id_contact_type': request.idContactType,
      'id_sales_1': request.idSales1,
      'id_sales_2': request.idSales2,
      'visit_at': request.visitAt,
      'proof': MultipartFile(
        request.proof,
        filename: request.proof?.path ?? '',
      ),
      'note': request.note,
    });
    var response = await post(path, body);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(path, BaseResponse(response.body['data']));
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }
}
