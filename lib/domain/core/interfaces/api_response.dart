import '../model/base_response.dart';
import '../model/failed_response.dart';

abstract class ApiResponse {
  void onFinishRequest(String path);

  void onStartRequest(String path);

  void onFailedRequest(String path, FailedResponse? failed);

  void onSuccessRequest(String path, BaseResponse response);
}
