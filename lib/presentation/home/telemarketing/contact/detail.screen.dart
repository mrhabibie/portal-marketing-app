import 'package:bps_portal_marketing/presentation/home/telemarketing/contact/controllers/detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class ContactDetailScreen extends GetView<ContactDetailController> {
  const ContactDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutral200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.purple,
        foregroundColor: Pallet.neutralWhite,
        centerTitle: true,
        title: Text(
          'app-name-text'.tr,
          style: TextStyles.title3.copyWith(color: Pallet.neutralWhite),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: AppDimension.style40,
                  child: Text(
                    controller.isLoading.isTrue
                        ? '?'
                        : (controller.contact?.name ?? '-').substring(0, 1),
                    style: TextStyles.largeNormalBold.copyWith(
                      fontSize: AppDimension.style40,
                    ),
                  ),
                ),
                SizedBox(height: AppDimension.height10),
                Text(
                  controller.isLoading.isTrue
                      ? '...'
                      : controller.contact?.name ?? '-',
                  style: TextStyles.largeNormalRegular.copyWith(
                    fontSize: AppDimension.style24,
                  ),
                ),
                SizedBox(height: AppDimension.height4),
                Text(
                  controller.isLoading.isTrue
                      ? '...'
                      : '${controller.contact?.group} (${controller.contact!.city}, ${controller.contact!.province})',
                  style: TextStyles.regularNormalRegular,
                ),
                SizedBox(height: AppDimension.height20),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  titleAlignment: ListTileTitleAlignment.center,
                  onTap: () {
                    controller.launch(Uri(
                      scheme: 'tel',
                      path: '+${controller.contact!.phoneNumber}',
                    ));
                  },
                  title: Text(
                    controller.isLoading.isTrue
                        ? '...'
                        : (controller.contact?.phoneNumber ?? '6282123456789')
                            .formatPhoneNumber,
                    style: TextStyles.regularNormalBold,
                  ),
                  trailing: Wrap(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => controller.launch(Uri(
                          scheme: 'tel',
                          path: '+${controller.contact!.phoneNumber}',
                        )),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith(
                              (states) => Pallet.success800.withOpacity(0.3)),
                        ),
                        icon: const Icon(
                          Iconsax.call5,
                          color: Pallet.success700,
                        ),
                      ),
                      SizedBox(width: AppDimension.width14),
                      IconButton(
                        onPressed: () => controller.launch(Uri(
                          scheme: 'sms',
                          path: '+${controller.contact!.phoneNumber}',
                        )),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith(
                              (states) => Pallet.info800.withOpacity(0.3)),
                        ),
                        icon: const Icon(
                          Iconsax.message5,
                          color: Pallet.info700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppDimension.height20),
                const Divider(
                  thickness: 0.5,
                  color: Pallet.neutral600,
                ),
                SizedBox(height: AppDimension.height20),
                Text(
                  'someone-address-text'.trParams({
                    'name': controller.isLoading.isTrue
                        ? '?'
                        : controller.contact?.name ?? '-'
                  }),
                  style: TextStyles.tinyNormalBold.copyWith(
                    color: Pallet.neutral600,
                  ),
                ),
                SizedBox(height: AppDimension.height10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.isLoading.isTrue
                      ? 3
                      : controller.contact?.addresses?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (controller.isLoading.isTrue) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const ShimmerLoading(),
                      );
                    } else {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          controller.launch(Uri.https(
                            'www.google.com',
                            '/maps/search/',
                            {
                              'api': '1',
                              'query':
                                  "${controller.contact!.addresses?.elementAt(index).address}"
                            },
                          ));
                        },
                        title: Text(
                          controller.contact!.addresses
                                  ?.elementAt(index)
                                  .address ??
                              '-',
                          style: TextStyles.regularNormalBold,
                        ),
                        subtitle: Text(
                          '${controller.contact!.addresses?.elementAt(index).name} (${controller.contact!.addresses?.elementAt(index).phone.formatPhoneNumber})',
                          style: TextStyles.smallNormalRegular,
                        ),
                        trailing: const Icon(Iconsax.export_3),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
