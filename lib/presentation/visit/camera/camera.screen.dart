import 'package:bps_portal_marketing/presentation/visit/camera/controllers/camera.controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../../infrastructure/utils/helpers/helper.dart';
import '../../../infrastructure/widgets/widgets.dart';

class CameraScreen extends GetView<CameraScreenController> {
  const CameraScreen({super.key});

  Widget _cameraPreviewWidget(Orientation orientation) {
    final CameraController? cameraController = controller.cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return SizedBox(
        height: AppDimension.height294,
        child: Center(
          child: Text(
            'failed-open-camera-text'.tr,
            style:
                TextStyles.largeNormalBold.copyWith(color: Pallet.neutralWhite),
          ),
        ),
      );
    } else {
      return Listener(
        onPointerDown: (event) => controller.pointers++,
        onPointerUp: (event) => controller.pointers--,
        child: AspectRatio(
          aspectRatio: orientation == Orientation.landscape
              ? controller.cameraController!.value.aspectRatio
              : (1 / controller.cameraController!.value.aspectRatio),
          child: CameraPreview(
            controller.cameraController!,
            child: LayoutBuilder(
              builder: (context, constraints) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onScaleStart: controller.handleScaleStart,
                onScaleUpdate: controller.handleScaleUpdate,
                onTapDown: (details) =>
                    controller.onViewFinderTap(details, constraints),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Spacer(),
                    Container(
                      height: 125,
                      color: Colors.black.withOpacity(0.5),
                      child: Row(
                        children: <Widget>[
                          Opacity(
                            opacity: 0.75,
                            child: Container(
                              width: 150,
                              color: Colors.white,
                              child: Obx(
                                () => GoogleMap(
                                  initialCameraPosition:
                                      controller.mapLocation!.value!,
                                  markers: controller.createMarker(),
                                  zoomControlsEnabled: false,
                                  tiltGesturesEnabled: false,
                                  zoomGesturesEnabled: false,
                                  mapToolbarEnabled: false,
                                  onMapCreated: (c) async {
                                    controller.mapController.complete(c);

                                    GoogleMapController gController =
                                        await controller.mapController.future;
                                    Future<void>.delayed(
                                        const Duration(milliseconds: 1000),
                                        () async {
                                      controller.mapSnapshot =
                                          await gController.takeSnapshot();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(AppDimension.style14),
                              child: WidgetsToImage(
                                controller: controller.addressImgController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      controller.placeMarks.isEmpty
                                          ? 'loading-text'.tr
                                          : '${controller.placeMarks.first.street}',
                                      style: TextStyles.description10
                                          .copyWith(color: Pallet.neutralWhite),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      controller.placeMarks.isEmpty
                                          ? 'loading-text'.tr
                                          : controller
                                              .placeMarks.first.locality!
                                              .replaceAll('Kecamatan', 'Kec.'),
                                      style: TextStyles.tinyNormalBold
                                          .copyWith(color: Pallet.neutralWhite),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      controller.placeMarks.isEmpty
                                          ? 'loading-text'.tr
                                          : '${controller.placeMarks.first.subAdministrativeArea}',
                                      style: TextStyles.tinyNormalBold
                                          .copyWith(color: Pallet.neutralWhite),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      controller.placeMarks.isEmpty
                                          ? 'loading-text'.tr
                                          : '${controller.placeMarks.first.administrativeArea}',
                                      style: TextStyles.tinyNormalBold
                                          .copyWith(color: Pallet.neutralWhite),
                                      textAlign: TextAlign.center,
                                    ),
                                    Obx(
                                      () => Text(
                                        controller
                                            .currentDate.value.toIdDateTime,
                                        style: TextStyles.tinyNormalBold
                                            .copyWith(
                                                color: Pallet.neutralWhite),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void onFlashButtonPressed() {
    if (controller.flashMode.value == FlashMode.off) {
      controller.flashMode(FlashMode.auto);
    } else if (controller.flashMode.value == FlashMode.auto) {
      controller.flashMode(FlashMode.torch);
    } else if (controller.flashMode.value == FlashMode.torch) {
      controller.flashMode(FlashMode.off);
    }

    controller.cameraController?.setFlashMode(controller.flashMode.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Pallet.neutralWhite,
        actions: <Widget>[
          IconButton(
            onPressed: controller.cameraController != null
                ? onFlashButtonPressed
                : null,
            icon: Icon(
              controller.flashMode.value == FlashMode.auto
                  ? Icons.flash_auto
                  : controller.flashMode.value == FlashMode.always ||
                          controller.flashMode.value == FlashMode.torch
                      ? Icons.flash_on
                      : Icons.flash_off,
              color: Pallet.neutralWhite,
            ),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _cameraPreviewWidget(orientation),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton.filled(
                      onPressed: () {
                        CameraDescription? camera =
                            controller.cameras.firstWhere(
                          (element) =>
                              element !=
                              controller.cameraController?.value.description,
                        );
                        controller.onNewCameraSelected(camera);
                      },
                      icon: Icon(
                        Icons.cameraswitch_rounded,
                        color: Pallet.neutralWhite,
                        size: AppDimension.style24,
                      ),
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Pallet.neutral700),
                      ),
                    ),
                    Obx(
                      () => Container(
                        margin: EdgeInsets.symmetric(
                            vertical: AppDimension.width20),
                        width: AppDimension.width68,
                        height: AppDimension.height68,
                        child: RoundedButtonWidget(
                          label: '',
                          backgroundColor: Pallet.neutral700,
                          borderSide: BorderSide(
                            color: const Color(0xffe0e0e0),
                            width: AppDimension.width4,
                          ),
                          borderRadius: AppDimension.roundedButton,
                          onPressed: controller.cameraButtonReady.isTrue
                              ? () => controller.takePicture(orientation)
                              : null,
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.recentImageFile.value != null
                          ? GestureDetector(
                              onTap: () async {
                                AppHelper.exitFullscreen();

                                Get.toNamed(
                                  Routes.SALES_GALLERY,
                                  arguments: {
                                    'files':
                                        controller.allFileList.reversed.toList()
                                  },
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    AppDimension.roundedButton),
                                child: Image.file(
                                  controller.recentImageFile.value!,
                                  fit: BoxFit.cover,
                                  width: AppDimension.width36,
                                  height: AppDimension.height36,
                                ),
                              ),
                            )
                          : Container(
                              width: AppDimension.width36,
                              height: AppDimension.height36,
                              decoration: BoxDecoration(
                                color: Pallet.neutral700,
                                borderRadius: BorderRadius.circular(
                                    AppDimension.roundedButton),
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _cameraPreviewWidget(orientation),
                SizedBox(width: AppDimension.width24),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton.filled(
                      onPressed: () {
                        CameraDescription? camera =
                            controller.cameras.firstWhere(
                          (element) =>
                              element !=
                              controller.cameraController?.value.description,
                        );
                        controller.onNewCameraSelected(camera);
                      },
                      icon: Icon(
                        Icons.cameraswitch_rounded,
                        color: Pallet.neutralWhite,
                        size: AppDimension.style24,
                      ),
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Pallet.neutral700),
                      ),
                    ),
                    Obx(
                      () => Container(
                        margin: EdgeInsets.symmetric(
                            vertical: AppDimension.width20),
                        width: AppDimension.width68,
                        height: AppDimension.height68,
                        child: RoundedButtonWidget(
                          label: '',
                          backgroundColor: Pallet.neutral700,
                          borderSide: BorderSide(
                            color: const Color(0xffe0e0e0),
                            width: AppDimension.width4,
                          ),
                          borderRadius: AppDimension.roundedButton,
                          onPressed: controller.cameraButtonReady.isTrue
                              ? () => controller.takePicture(orientation)
                              : null,
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.recentImageFile.value != null
                          ? GestureDetector(
                              onTap: () async {
                                AppHelper.exitFullscreen();

                                var result =
                                    await Get.toNamed(Routes.SALES_GALLERY);
                                if (result != null) {
                                  await controller.getGallery();

                                  AppHelper.enterFullscreen();
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    AppDimension.roundedButton),
                                child: Image.file(
                                  controller.recentImageFile.value!,
                                  fit: BoxFit.cover,
                                  width: AppDimension.width36,
                                  height: AppDimension.height36,
                                ),
                              ),
                            )
                          : Container(
                              width: AppDimension.width36,
                              height: AppDimension.height36,
                              decoration: BoxDecoration(
                                color: Pallet.neutral700,
                                borderRadius: BorderRadius.circular(
                                    AppDimension.roundedButton),
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
