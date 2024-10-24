import 'package:bps_portal_marketing/domain/core/model/master/response/master_city_response.dart';
import 'package:bps_portal_marketing/domain/core/model/master/response/master_contact_type_response.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/type/controllers/new.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class NewTypeScreen extends GetView<NewTypeController> {
  const NewTypeScreen({super.key});

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
                  : () => controller.createType(),
              icon: const Icon(
                Icons.check,
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
                'add-group-text'.tr,
                style: TextStyles.largeNormalBold,
              ),
              const SizedBox(height: 20),
              CustomTextInput(
                title: 'name-text'.tr,
                isRequired: true,
                validator: controller.name,
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              Obx(
                () => CustomDropdownInput(
                  title: 'type-text'.tr,
                  isRequired: true,
                  validator: controller.type,
                  hint:
                      controller.isTypeLoading.isTrue ? 'loading-text'.tr : '',
                  items: controller.types.map<DropdownMenuItem>(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        value.name,
                        style: TextStyles.regularNormalRegular,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    var type = value as MasterContactTypeResponse;
                    controller.type.value = type;
                  },
                ),
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
                            validator: controller.search,
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
                                  PagedChildBuilderDelegate<MasterCity>(
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
                                    controller.city.value = item;
                                    controller.city.controller?.text =
                                        item.name;
                                    Get.back();
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Iconsax.location5),
                                  title: Text(
                                    item.name,
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
            ],
          ),
        ),
      ),
    );
  }
}
