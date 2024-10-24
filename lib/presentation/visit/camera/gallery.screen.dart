import 'package:bps_portal_marketing/presentation/visit/camera/controllers/gallery.controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class GalleryScreen extends GetView<GalleryScreenController> {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Pallet.neutralWhite,
      ),
      body: controller.files.isNotEmpty
          ? CarouselSlider.builder(
              itemCount: controller.files.length,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: Get.size.height - 45,
                viewportFraction: 1,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {},
              ),
              itemBuilder: (context, index, realIndex) =>
                  Image.file(controller.files.elementAt(index)),
            )
          : Center(
              child: Text(
                'no-photo-found-text'.tr,
                style: TextStyles.regularNormalRegular
                    .copyWith(color: Pallet.neutralWhite),
              ),
            ),
    );
  }
}
