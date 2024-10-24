import 'package:bps_portal_marketing/domain/core/model/login/response/login_response.dart';

import '../interfaces/api_response.dart';
import '../model/base_response.dart';
import '../network/api_client.dart';
import '../network/api_url.dart';

class ProfileProvider extends ApiClient {
  final ApiResponse apiResponse;

  ProfileProvider(this.apiResponse) {
    super.onInit();
  }

  void getProfile() async {
    String path = ApiUrl.profile;
    apiResponse.onStartRequest(path);
    var response = await get(path);
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
}
