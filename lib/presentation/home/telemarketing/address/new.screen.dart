import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_type_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_addresses_response.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/address/controllers/new.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class NewAddressScreen extends GetView<NewAddressController> {
  const NewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutralWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.info700,
        foregroundColor: Pallet.neutralWhite,
        centerTitle: true,
        title: Text(
          'app-name-text'.tr,
          style: TextStyles.title3.copyWith(color: Pallet.neutralWhite),
        ),
        actions: <Widget>[
          Obx(
            () => IconButton(
              tooltip: 'save-text'.tr,
              onPressed: controller.isLoading.isTrue
                  ? null
                  : () => controller.createAddress(),
              icon: const Icon(
                Icons.check,
                size: 28,
                color: Pallet.neutralWhite,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'add-address-text'.tr,
                style: TextStyles.largeNormalBold,
              ),
              const SizedBox(height: 20),
              CustomTextInput(
                title: 'group-text'.tr,
                isNeedSearch: false,
                isNeedClear: false,
                isRequired: true,
                isNeedDropdown: true,
                isReadOnly: true,
                validator: controller.type,
                onChanged: (value) {},
                onTap: () {
                  controller.pagingGroupController.refresh();

                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: Pallet.neutralWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextInput(
                            validator: controller.searchGroup,
                            isNeedSearch: true,
                            hideCaption: true,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                controller.pagingGroupController.refresh();
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                controller.pagingGroupController.refresh();
                              }
                            },
                          ),
                          SizedBox(height: AppDimension.height10),
                          Expanded(
                            child: PagedListView(
                              pagingController:
                                  controller.pagingGroupController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<ContactType>(
                                firstPageProgressIndicatorBuilder: (context) =>
                                    const Center(
                                  child: CircularProgressIndicator(
                                      color: Pallet.info700),
                                ),
                                newPageProgressIndicatorBuilder: (context) =>
                                    const Center(
                                  child: CircularProgressIndicator(
                                      color: Pallet.info700),
                                ),
                                itemBuilder: (context, item, index) => ListTile(
                                  onTap: () {
                                    controller.type.value = item;
                                    controller.type.controller?.text =
                                        '${item.name} (${item.city}, ${item.province})';
                                    Get.back();
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Iconsax.location),
                                  title: Text(
                                    item.name,
                                    style: TextStyles.regularNormalRegular,
                                  ),
                                  subtitle: Text(
                                    '${item.city}, ${item.province}',
                                    style: TextStyles.smallNormalRegular
                                        .copyWith(color: Pallet.neutral700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomTextInput(
                title: 'receiver-name-text'.tr,
                isRequired: true,
                validator: controller.name,
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              CustomTextInput(
                title: 'phone-text'.tr,
                isRequired: true,
                validator: controller.phone,
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              CustomTextInput(
                title: 'city-text'.tr,
                isNeedSearch: false,
                isNeedClear: false,
                isRequired: true,
                isNeedDropdown: true,
                isReadOnly: true,
                validator: controller.city,
                onChanged: (value) {},
                onTap: () {
                  controller.pagingCityController.refresh();

                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: Pallet.neutralWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextInput(
                            validator: controller.searchCity,
                            isNeedSearch: true,
                            hideCaption: true,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                controller.pagingCityController.refresh();
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                controller.pagingCityController.refresh();
                              }
                            },
                          ),
                          SizedBox(height: AppDimension.height10),
                          Expanded(
                            child: PagedListView(
                              pagingController: controller.pagingCityController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<MasterAddress>(
                                firstPageProgressIndicatorBuilder: (context) =>
                                    const Center(
                                  child: CircularProgressIndicator(
                                      color: Pallet.info700),
                                ),
                                newPageProgressIndicatorBuilder: (context) =>
                                    const Center(
                                  child: CircularProgressIndicator(
                                      color: Pallet.info700),
                                ),
                                itemBuilder: (context, item, index) => ListTile(
                                  selectedColor: Pallet.info700,
                                  onTap: () {
                                    controller.city.value = item;
                                    controller.city.controller?.text =
                                        item.fullAddress;
                                    Get.back();
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Iconsax.location),
                                  title: Text(
                                    item.fullAddress,
                                    style: TextStyles.regularNormalRegular,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomTextInput(
                title: 'address-text'.tr,
                isRequired: true,
                validator: controller.address,
                isExpanded: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
