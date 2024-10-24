import 'package:bps_portal_marketing/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/theme/theme.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Pallet.neutralWhite,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Iconsax.home_25),
              label: controller.currentPageIndex.value == 0 ? "•" : "",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Iconsax.call5),
              label: controller.currentPageIndex.value == 1 ? "•" : "",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Iconsax.location5),
              label: controller.currentPageIndex.value == 2 ? "•" : "",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Iconsax.candle5),
              label: controller.currentPageIndex.value == 3 ? "•" : "",
            ),
          ],
          selectedItemColor: Pallet.purple,
          unselectedItemColor: Pallet.neutral500,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentPageIndex.value,
        ),
      ),
      body: Obx(() => controller.pages[controller.currentPageIndex.value]),
    );
  }
}
