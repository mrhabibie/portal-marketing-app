import 'package:bps_portal_marketing/domain/core/model/login/request/login_request.dart';
import 'package:bps_portal_marketing/domain/core/model/login/response/login_response.dart';
import 'package:bps_portal_marketing/domain/core/model/register/request/register_request.dart';

import '../interfaces/api_response.dart';
import '../model/base_response.dart';
import '../network/api_client.dart';
import '../network/api_url.dart';

class AuthProvider extends ApiClient {
  final ApiResponse apiResponse;

  AuthProvider(this.apiResponse) {
    super.onInit();
  }

  void login({required LoginRequest request}) async {
    String path = ApiUrl.login;
    apiResponse.onStartRequest(path);
    super.body = request.toJson();
    var response = await post(path, {'data': request.toJson()});
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<LoginResponse>(
            LoginResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void register({required RegisterRequest request}) async {
    String path = ApiUrl.register;
    apiResponse.onStartRequest(path);
    super.body = request.toJson();
    var response = await post(path, {'data': request.toJson()});
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<String>(response.body['data']),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }
}
