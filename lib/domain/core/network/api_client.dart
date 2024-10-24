import 'dart:convert';

import 'package:get/get.dart';

import '../../../config.dart';
import '../../../infrastructure/utils/helpers/log_helper.dart';
import '../../../infrastructure/utils/helpers/pref_helper.dart';
import '../../../infrastructure/utils/services/crashlytics.service.dart';
import '../model/failed_response.dart';

class ApiClient extends GetConnect {
  FailedResponse? failed;
  Map? body;
  Map<String, dynamic>? params;

  @override
  void onInit() {
    httpClient.baseUrl = ConfigEnvironments.getEnvironments()['api-url'];
    httpClient.defaultContentType = 'application/json';
    httpClient.timeout = const Duration(seconds: 60);
    httpClient.addRequestModifier<dynamic>((request) async {
      if (PrefHelper.to.getToken() != null) {
        request.headers
            .addAll({'Authorization': 'Bearer ${PrefHelper.to.getToken()}'});
      }
      request.headers.addAll({
        'Accept': 'application/json',
        /*'x-api-key': ConfigEnvironments.getEnvironments()['api-key'] ?? '',
        'api-version':
            ConfigEnvironments.getEnvironments()['api-version'] ?? '',*/
      });
      return request;
    });
    httpClient.addResponseModifier((request, response) async {
      try {
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        final String prettyJson = encoder.convert(response.body);
        log.d(
          "REQUEST ► ${request.method} ${request.method.toUpperCase()} ${request.url}\n\n"
          "Headers:\n"
          "${request.headers.getAllString()}\n"
          "Request Param: \n ${params.toString()}\n"
          "Request Body: \n ${body.toString()}\n"
          "Response Body ${response.statusCode} : $prettyJson",
        );

        if (!response.isOk) {
          failed = FailedResponse.fromJson(response.body);
        }
      } on Exception catch (e) {
        log.d('==> Error: $e');
        failed = FailedResponse(
          responseCode: 500,
          message: e.toString(),
          status: 0,
          data: e.toString(),
        );
        Crashlytics.apiError(error: e);
      }
      return response;
    });
    super.onInit();
  }
}
