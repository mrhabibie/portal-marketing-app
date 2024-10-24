import 'package:bps_portal_marketing/domain/core/interfaces/api_response.dart';
import 'package:bps_portal_marketing/domain/core/model/base_response.dart';
import 'package:bps_portal_marketing/domain/core/model/home/response/price_response.dart';
import 'package:bps_portal_marketing/domain/core/network/api_client.dart';
import 'package:bps_portal_marketing/domain/core/network/api_url.dart';

class PriceProvider extends ApiClient {
  final ApiResponse apiResponse;

  PriceProvider(this.apiResponse) {
    super.onInit();
  }

  void getPrice() async {
    String path = ApiUrl.home;
    apiResponse.onStartRequest(path);
    var response = await get(path);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<PriceResponse>(PriceResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }
}
