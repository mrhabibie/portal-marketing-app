import 'dart:io';

import 'package:bps_portal_marketing/domain/core/model/login/response/login_response.dart';
import 'package:bps_portal_marketing/domain/core/model/visit/response/visit_response.dart';
import 'package:bps_portal_marketing/domain/core/providers/profile.provider.dart';
import 'package:bps_portal_marketing/domain/core/providers/visit.provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as Geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../domain/core/interfaces/api_response.dart';
import '../../../domain/core/model/base_response.dart';
import '../../../domain/core/model/failed_response.dart';
import '../../../domain/core/network/api_url.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/utils/helpers/helper.dart';
import '../../../infrastructure/widgets/widgets.dart';

class VisitController extends GetxController implements ApiResponse {
  late final VisitProvider _provider = VisitProvider(this);
  late final ProfileProvider _profileProvider = ProfileProvider(this);

  RxBool isLoading = false.obs;

  Rxn<LoginResponse>? profile = Rxn<LoginResponse>();
  Rx<VisitResponse> visit = VisitResponse(
    todayVisit: 0,
    historyVisit: [],
  ).obs;

  void getDashboard() {
    isLoading(true);
    _profileProvider.getProfile();
  }

  @override
  void onInit() {
    getDashboard();
    super.onInit();
  }

  @override
  void onClose() {
    _profileProvider.dispose();
    _provider.dispose();
    super.onClose();
  }

  void checkPermissions() async {
    LoadingDialog();

    await availableCameras();

    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      Get.closeAllSnackbars();
      Navigator.of(Get.overlayContext!).pop();
      SnackbarError(
        'whoops-text'.tr,
        'Please enable location service in Phone settings.',
      );
      return;
    }

    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.deniedForever) {
      Get.closeAllSnackbars();
      Navigator.of(Get.overlayContext!).pop();
      SnackbarError(
        'whoops-text'.tr,
        'You need to enable location permission to continue using the application.',
      );
      return;
    }

    LocationData locationData = await location.getLocation();
    if (locationData.isBlank == true) {
      Get.closeAllSnackbars();
      Navigator.of(Get.overlayContext!).pop();
      SnackbarError(
        'whoops-text'.tr,
        'Failed to get user position.',
      );
      return;
    }

    List<Geocoding.Placemark> placeMarks = [];
    final lookup = await InternetAddress.lookup('google.com');
    if (lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty) {
      placeMarks = await Geocoding.placemarkFromCoordinates(
        locationData.latitude ?? 0.0,
        locationData.longitude ?? 0,
      );
    } else {
      Get.closeAllSnackbars();
      Navigator.of(Get.overlayContext!).pop();
      SnackbarError(
        'whoops-text'.tr,
        'Unable to connect to the internet, please check your connection.',
      );
      return;
    }

    AppHelper.setDefaultDir().then((_) {
      Get.closeAllSnackbars();
      Navigator.of(Get.overlayContext!).pop();

      Get.toNamed(
        Routes.SALES_CAMERA,
        arguments: {
          'mapLocation': CameraPosition(
            target: LatLng(
              locationData.latitude ?? 0.0,
              locationData.longitude ?? 0.0,
            ),
            zoom: 14.4746,
          ),
          'locationData': locationData,
          'placeMarks': placeMarks,
        },
      );
    }).onError((error, stackTrace) {
      SnackbarError('whoops-text'.tr, error.toString());
      return;
    });
  }

  @override
  void onFailedRequest(String path, FailedResponse? failed) {
    AppDialog(
      title: 'whoops-text'.tr,
      description: failed?.data ?? 'error-text'.tr,
      isSuccess: false,
    );
  }

  @override
  void onFinishRequest(String path) {
    isLoading(false);
  }

  @override
  void onStartRequest(String path) {
    isLoading(true);
  }

  @override
  void onSuccessRequest(String path, BaseResponse response) {
    switch (path) {
      case ApiUrl.profile:
        profile!(response.data as LoginResponse);
        _provider.getVisitDashboard();
        break;
      case ApiUrl.getVisit:
        visit(response.data as VisitResponse);
        break;
    }
  }
}
