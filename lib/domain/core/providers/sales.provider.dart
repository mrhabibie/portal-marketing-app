import 'package:bps_portal_marketing/domain/core/model/sales_invoice/response/sales_invoice_response.dart';

import '../interfaces/api_response.dart';
import '../model/base_response.dart';
import '../network/api_client.dart';
import '../network/api_url.dart';

class SalesProvider extends ApiClient {
  final ApiResponse apiResponse;

  SalesProvider(this.apiResponse) {
    super.onInit();
  }

  Future<void> getSalesInvoice({
    String? keyword,
    String? between,
    int page = 1,
  }) async {
    String path = ApiUrl.getSalesInvoice;
    apiResponse.onStartRequest(path);
    super.params = {
      "keyword": keyword,
      "between": between,
      "page": page.toString(),
    };
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<SalesInvoiceResponse>(
            SalesInvoiceResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  Future<void> getSalesInvoiceDetail({required int id}) async {
    String path = ApiUrl.getSalesInvoiceDetail;
    apiResponse.onStartRequest(path);
    super.params = {"id": id.toString()};
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<SalesInvoice>(
            SalesInvoice.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }
}
