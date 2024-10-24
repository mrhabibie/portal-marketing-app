import 'package:bps_portal_marketing/domain/core/model/master/response/master_brand_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_response.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/follow_up/controllers/new.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class FollowUpNewScreen extends GetView<FollowUpNewController> {
  const FollowUpNewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutral200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.neutral200,
        foregroundColor: Pallet.neutral700,
        centerTitle: true,
        title: Text(
          'app-name-text'.tr,
          style: TextStyles.title3,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimension.style20),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'add-response-text'.tr,
                  style: TextStyles.largeNormalBold,
                ),
                SizedBox(height: AppDimension.height20),
                CustomDropdownInput(
                  title: 'brand-text'.tr,
                  isRequired: true,
                  isReadOnly: controller.isLoading.isTrue,
                  validator: controller.brand,
                  hint:
                      controller.isBrandLoading.isTrue ? 'loading-text'.tr : '',
                  items: controller.brands.map<DropdownMenuItem>(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        value.name,
                        style: TextStyles.regularNormalRegular,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    var type = value as MasterBrand;
                    controller.brand.value = type;
                  },
                ),
                SizedBox(height: AppDimension.height10),
                CustomTextInput(
                  title: 'customer-text'.tr,
                  isNeedSearch: false,
                  isNeedClear: false,
                  isRequired: true,
                  isNeedDropdown: true,
                  isReadOnly: true,
                  validator: controller.contactName,
                  onChanged: (value) {},
                  onTap: () {
                    controller.pagingController.refresh();

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
                              validator: controller.keyword,
                              hint: "find-store-contact-location-customer-text"
                                  .tr,
                              isNeedSearch: true,
                              hideCaption: true,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  controller.pagingController.refresh();
                                }
                              },
                              onFieldSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  controller.pagingController.refresh();
                                }
                              },
                            ),
                            SizedBox(height: AppDimension.height10),
                            Expanded(
                              child: PagedListView(
                                pagingController: controller.pagingController,
                                builderDelegate:
                                    PagedChildBuilderDelegate<MasterContact>(
                                  firstPageProgressIndicatorBuilder:
                                      (context) => const Center(
                                    child: CircularProgressIndicator(
                                        color: Pallet.info700),
                                  ),
                                  newPageProgressIndicatorBuilder: (context) =>
                                      const Center(
                                    child: CircularProgressIndicator(
                                        color: Pallet.info700),
                                  ),
                                  itemBuilder: (context, item, index) =>
                                      ListTile(
                                    onTap: () {
                                      controller.contact.value = item;
                                      controller.contactName.controller?.text =
                                          '${item.name} (${item.city}, ${item.province})';
                                      controller.keyword.controller?.value =
                                          TextEditingValue(text: item.name);
                                      Get.back();
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    leading: const Icon(Iconsax.user),
                                    title: Text(
                                      item.name,
                                      style: TextStyles.regularNormalRegular,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          item.phoneNumber.formatPhoneNumber,
                                          style: TextStyles.smallNormalRegular
                                              .copyWith(
                                            color: Pallet.neutral600,
                                          ),
                                        ),
                                        Text(
                                          '(${item.role} ${item.group}) ${item.city}, ${item.province}',
                                          style: TextStyles.smallNormalRegular
                                              .copyWith(
                                            color: Pallet.neutral600,
                                          ),
                                        ),
                                      ],
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
                SizedBox(height: AppDimension.height10),
                CustomTextInput(
                  title: 'date-text'.tr,
                  isNeedSearch: false,
                  isNeedClear: false,
                  isRequired: true,
                  isReadOnly: true,
                  validator: controller.date,
                  onChanged: (value) {},
                  onTap: () => controller.chooseDate(),
                ),
                SizedBox(height: AppDimension.height10),
                CustomDropdownInput(
                  title: 'status-text'.tr,
                  isRequired: true,
                  validator: controller.status,
                  hint: '',
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                      value: 0,
                      child: Text(
                        'n-a-text'.tr,
                        style: TextStyles.regularNormalRegular,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text(
                        'potential-text'.tr,
                        style: TextStyles.regularNormalRegular,
                      ),
                    ),
                    DropdownMenuItem(
                      value: -1,
                      child: Text(
                        'not-potential-text'.tr,
                        style: TextStyles.regularNormalRegular,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    controller.status.value = value;
                  },
                ),
                SizedBox(height: AppDimension.height10),
                CustomTextInput(
                  title: 'response-text'.tr,
                  isRequired: true,
                  isExpanded: true,
                  isReadOnly: controller.isLoading.isTrue,
                  validator: controller.response,
                  onChanged: (value) {},
                ),
                SizedBox(height: AppDimension.height40),
                RoundedButtonWidget(
                  label: controller.isLoading.isTrue
                      ? 'loading-text'.tr
                      : 'save-text'.tr,
                  onPressed: controller.isLoading.isTrue
                      ? null
                      : () => controller.createResponse(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
