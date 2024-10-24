import 'package:bps_portal_marketing/domain/core/model/master/response/master_addresses_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_area_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_brand_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_city_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_type_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_province_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_suburb_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_user_response.dart';

import '../interfaces/api_response.dart';
import '../model/base_response.dart';
import '../network/api_client.dart';
import '../network/api_url.dart';

class MasterProvider extends ApiClient {
  final ApiResponse apiResponse;

  MasterProvider(this.apiResponse) {
    super.onInit();
  }

  void getProvinces() async {
    String path = ApiUrl.masterProvinces;
    apiResponse.onStartRequest(path);
    var response = await get(path);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<List<MasterProvinceResponse>>(
            List<MasterProvinceResponse>.from(response.body['data']
                .map((json) => MasterProvinceResponse.fromJson(json)))),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  Future<void> getCities({
    String? keyword,
    bool withProvince = false,
    int page = 1,
  }) async {
    String path = ApiUrl.masterCities;
    apiResponse.onStartRequest(path);
    super.params = {
      'keyword': keyword,
      'with_province': withProvince.toString(),
      'page': page.toString(),
    };
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<MasterCityResponse>(
            MasterCityResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void getSuburbs({required int cityId}) async {
    String path = ApiUrl.masterSuburbs;
    apiResponse.onStartRequest(path);
    super.params = {"city_id": '$cityId'};
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<List<MasterSuburbResponse>>(
            List<MasterSuburbResponse>.from(response.body['data']
                .map((json) => MasterSuburbResponse.fromJson(json)))),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void getAreas({required int suburbId}) async {
    String path = ApiUrl.masterAreas;
    apiResponse.onStartRequest(path);
    super.params = {"suburb_id": '$suburbId'};
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<List<MasterAreaResponse>>(List<MasterAreaResponse>.from(
            response.body['data']
                .map((json) => MasterAreaResponse.fromJson(json)))),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  Future<void> getFullAddresses({String? keyword, int page = 1}) async {
    String path = ApiUrl.masterFullAddresses;
    apiResponse.onStartRequest(path);
    super.params = {"keyword": keyword, "page": page.toString()};
    var response = await get(path, query: super.params);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<MasterAddressesResponse>(
            MasterAddressesResponse.fromJson(response.body['data'])),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void getContactType() async {
    String path = ApiUrl.masterContactType;
    apiResponse.onStartRequest(path);
    var response = await get(path);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<List<MasterContactTypeResponse>>(
            List<MasterContactTypeResponse>.from(response.body['data']
                .map((json) => MasterContactTypeResponse.fromJson(json)))),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void getBrand() async {
    String path = ApiUrl.masterBrands;
    apiResponse.onStartRequest(path);
    var response = await get(path);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<List<MasterBrand>>(List<MasterBrand>.from(
            response.body['data'].map((json) => MasterBrand.fromJson(json)))),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }

  void getUsers() async {
    String path = ApiUrl.masterUsers;
    apiResponse.onStartRequest(path);
    var response = await get(path);
    apiResponse.onFinishRequest(path);
    if (response.isOk) {
      apiResponse.onSuccessRequest(
        path,
        BaseResponse<List<MasterUserResponse>>(List<MasterUserResponse>.from(
            response.body['data']
                .map((json) => MasterUserResponse.fromJson(json)))),
      );
    } else {
      apiResponse.onFailedRequest(path, failed);
    }
  }
}
