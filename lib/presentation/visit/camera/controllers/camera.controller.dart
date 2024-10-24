import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as Geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../../domain/core/model/model.dart';
import '../../../../infrastructure/utils/helpers/helper.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class CameraScreenController extends FullLifeCycleController
    with FullLifeCycleMixin {
  CameraController? cameraController;
  Uint8List? mapSnapshot;
  WidgetsToImageController addressImgController = WidgetsToImageController();
  WidgetsToImageController previewImageController = WidgetsToImageController();

  List<CameraDescription> cameras = <CameraDescription>[];
  Rx<FlashMode> flashMode = FlashMode.off.obs;

  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  Rxn<CameraPosition>? mapLocation = Rxn<CameraPosition>();
  Position? userPosition;
  RxList<Geocoding.Placemark> placeMarks = <Geocoding.Placemark>[].obs;
  Rx<DateTime> currentDate = DateTime.now().obs;

  Rxn<File> recentImageFile = Rxn<File>();
  final List<File> allFileList = [];
  String? _savePhotoPath = 'Loading...';

  List<String> zoomText = [];
  double _minAvailExposureOffset = 0.0;
  double _maxAvailExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  double _minAvailZoom = 1.0;
  double _maxAvailZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  // Counting pointers (number of user fingers on screen)
  int pointers = 0;

  RxBool cameraButtonReady = false.obs;
  bool _hasSdCard = false;
  Timer? _timer;

  void _init() async {
    flashMode(FlashMode.off);

    cameraButtonReady(false);

    zoomText = [];

    _getAvailableCameras().then((_) {
      onNewCameraSelected(cameras[0]).then((_) {
        zoomText.add(_minAvailZoom.toStringAsFixed(1));
        zoomText.add((_maxAvailZoom / 2).toStringAsFixed(1));
        zoomText.add(_maxAvailZoom.toStringAsFixed(1));

        AppHelper.enterFullscreen();

        _getUserLocation().then((_) {
          _getUserAddress().then((_) {
            _hasSdCardSlot().then((_) {
              getGallery().then((_) {
                AppHelper.getDefaultDir().then((SettingPhotoDirs dirs) {
                  _savePhotoPath = dirs.dirs
                      .firstWhere((element) => element.isSelected)
                      .title;

                  cameraButtonReady(true);
                  refresh();
                });
              });
            });
          }).onError((error, stackTrace) {
            SnackbarError('whoops-text'.tr, '$error');
            return;
          });
        }).onError((error, stackTrace) {
          SnackbarError('whoops-text'.tr, '$error');
          return;
        });
      }).onError((error, stackTrace) {
        SnackbarError('whoops-text'.tr, '$error');
        return;
      });
    }).onError((error, stackTrace) {
      SnackbarError('whoops-text'.tr, '$error');
      return;
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        currentDate(DateTime.now());
      },
    );
  }

  Future<void> _getAvailableCameras() async {
    cameras = await availableCameras();
  }

  Future<void> onNewCameraSelected(CameraDescription description) async {
    final CameraController? oldController = cameraController;
    if (oldController != null) {
      cameraController = null;
      await oldController.dispose();
    }

    final CameraController newCameraController = CameraController(
      description,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    cameraController = newCameraController;

    newCameraController.addListener(
      () {
        if (newCameraController.value.hasError) {
          SnackbarError(
            'whoops-text'.tr,
            'Camera error: ${newCameraController.value.errorDescription}',
          );
        }
      },
    );

    try {
      await newCameraController.initialize();
      await Future.wait(<Future<Object?>>[
        ...<Future<Object?>>[
          newCameraController.getMinExposureOffset().then(
                (double value) => _minAvailExposureOffset = value,
              ),
          newCameraController
              .getMaxExposureOffset()
              .then((double value) => _maxAvailExposureOffset = value),
        ],
        newCameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailZoom = value),
        newCameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailZoom = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          SnackbarError(
            'whoops-text'.tr,
            'You have denied camera access.',
          );
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          SnackbarError(
            'whoops-text'.tr,
            'Please go to Settings app to enable camera access.',
          );
          break;
        case 'CameraAccessRestricted':
          SnackbarError(
            'whoops-text'.tr,
            'Camera access is restricted.',
          );
          break;
        case 'AudioAccessDenied':
          SnackbarError(
            'whoops-text'.tr,
            'You have denied audio access.',
          );
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          SnackbarError(
            'whoops-text'.tr,
            'Please go to Settings app to enable audio access.',
          );
          break;
        case 'AudioAccessRestricted':
          SnackbarError(
            'whoops-text'.tr,
            'Audio access is restricted.',
          );
          break;
        default:
          _showCameraException(e);
          break;
      }
    }
  }

  Future<void> _getUserLocation() async {
    mapLocation!(Get.arguments['mapLocation']);
  }

  Future<void> _getUserAddress() async {
    placeMarks(Get.arguments['placeMarks']);
  }

  Future<void> _hasSdCardSlot() async {
    List<Directory>? externalStorageDirectories =
        await getExternalStorageDirectories();
    for (Directory directory in externalStorageDirectories) {
      if (directory.path.contains("sdcard")) {
        _hasSdCard = true;
      }
    }
  
    _hasSdCard = false;
  }

  Set<Marker> createMarker() {
    return <Marker>{
      Marker(
        markerId: const MarkerId("marker_1"),
        draggable: false,
        position: mapLocation?.value?.target ?? const LatLng(0.0, 0.0),
        icon: BitmapDescriptor.defaultMarker,
      ),
    };
  }

  void handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> handleScaleUpdate(ScaleUpdateDetails details) async {
    if (cameraController == null || pointers != 2) {
      return;
    }

    _currentScale =
        (_baseScale * details.scale).clamp(_minAvailZoom, _maxAvailZoom);

    await cameraController!.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (cameraController == null) return;

    final CameraController newCameraController = cameraController!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    newCameraController.setExposurePoint(offset);
    newCameraController.setFocusPoint(offset);
  }

  void _showCameraException(CameraException e) {
    SnackbarError('whoops-text'.tr, '${e.description}');
  }

  Future<void> takePicture(Orientation orientation) async {
    String fileName = '';
    String dirPhoto = '';

    File photoCaptured;
    File mapCaptured;
    File addressCaptured;
    File previewCaptured;

    LoadingDialog();

    await AppHelper.getDefaultFilename(exportAs: String)
        .then((value) => fileName = value);
    await AppHelper.getDefaultDir().then((dirs) {
      dirPhoto = dirs.dirs.firstWhere((dir) => dir.isSelected).dirPath;
    });
    // await AppHelper.getSaveOriPhoto().then((value) => _saveOriPhotos = value);

    if (fileName.isEmpty || dirPhoto.isEmpty) {
      Get.closeAllSnackbars();
      Navigator.of(Get.overlayContext!).pop();
      SnackbarError(
        'whoops-text'.tr,
        'File name and dir photo is required.',
      );
      return;
    }

    if (!Directory(dirPhoto).existsSync()) {
      Directory(dirPhoto).createSync(recursive: true);
    }

    try {
      Uint8List? pngBytes = await addressImgController.capture();
      addressCaptured = File('$dirPhoto/Address_$fileName');
      addressCaptured.writeAsBytes(pngBytes!);
    } catch (e) {
      Get.closeAllSnackbars();
      Navigator.of(Get.overlayContext!).pop();
      SnackbarError('whoops-text'.tr, e.toString());
      return;
    }

    try {
      mapCaptured = File('$dirPhoto/Map_$fileName');
      mapCaptured.writeAsBytes(mapSnapshot!);
    } catch (e) {
      Get.closeAllSnackbars();
      Navigator.of(Get.overlayContext!).pop();
      SnackbarError('whoops-text'.tr, e.toString());
      return;
    }

    try {
      await cameraController?.takePicture().then((XFile? picture) async {
        picture?.saveTo('$dirPhoto/Photo_$fileName');
        photoCaptured = File('$dirPhoto/Photo_$fileName');

        Get.closeAllSnackbars();
        Navigator.of(Get.overlayContext!).pop();

        await Get.dialog(
          barrierDismissible: false,
          barrierColor: Colors.black,
          Dialog(
            backgroundColor: Colors.black,
            insetPadding: EdgeInsets.zero,
            child: WidgetsToImage(
              controller: previewImageController,
              child: AspectRatio(
                aspectRatio: orientation == Orientation.landscape
                    ? cameraController!.value.aspectRatio
                    : (1 / cameraController!.value.aspectRatio),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.file(
                      photoCaptured,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Spacer(),
                        Container(
                          height: 125,
                          color: Colors.black.withOpacity(0.5),
                          child: Row(
                            children: <Widget>[
                              Image.file(mapCaptured),
                              Expanded(child: Image.file(addressCaptured)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ).then((value) async {
          LoadingDialog();

          Uint8List? pngBytes = await previewImageController.capture();
          previewCaptured = File('$dirPhoto/$fileName');
          await previewCaptured.writeAsBytes(pngBytes!);

          await photoCaptured.delete();
          await mapCaptured.delete();
          await addressCaptured.delete();

          Get.closeAllSnackbars();
          Navigator.of(Get.overlayContext!).pop();

          await MediaScanner.loadMedia(path: dirPhoto);
          await getGallery();
        });
      }).onError((error, stackTrace) {
        throw Exception(error.toString());
      });
    } on CameraException catch (e) {
      Get.closeAllSnackbars();
      Navigator.of(Get.overlayContext!).pop();
      SnackbarError('whoops-text'.tr, e.toString());
      return;
    }
  }

  Future<void> getGallery() async {
    // Get the directory
    final defaultDir = await AppHelper.getDefaultDir();
    String dir =
        defaultDir.dirs.firstWhere((element) => element.isSelected).dirPath;
    String newDir = dir.replaceAll(dir.split('/').last, '');
    final Directory directory = Directory(newDir);
    List<FileSystemEntity> fileList = await directory.list().toList();
    recentImageFile(null);
    allFileList.clear();

    // Searching for all the image files using
    // their default format, and storing them
    for (var file in fileList) {
      if (!file.path.contains('.jpg')) {
        final Directory nD = Directory(file.path);
        List<FileSystemEntity> dirFiles = await nD.list().toList();
        for (var nF in dirFiles) {
          if (nF.path.contains('.jpg') &&
              !nF.path.split('/').last.contains('.trashed')) {
            allFileList.add(File(nF.path));
          }
        }
      } else {
        if (file.path.contains('.jpg') &&
            !file.path.split('/').last.contains('.trashed')) {
          allFileList.add(File(file.path));
        }
      }
    }

    allFileList
        .sort((a, b) => a.lastModifiedSync().compareTo(b.lastModifiedSync()));

    // Retrieving the recent file
    if (allFileList.isNotEmpty) {
      recentImageFile(File(allFileList.last.path));
    }
  }

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  @override
  void onClose() {
    AppHelper.exitFullscreen();
    cameraController?.dispose();
    cameraController = null;
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onDetached() {
    AppHelper.exitFullscreen();
    cameraController?.dispose();
    cameraController = null;
    _timer?.cancel();
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
