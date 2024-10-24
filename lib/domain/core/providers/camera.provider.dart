import '../interfaces/api_response.dart';
import '../network/api_client.dart';

class CameraProvider extends ApiClient {
  final ApiResponse apiResponse;

  CameraProvider(this.apiResponse) {
    super.onInit();
  }
}
