import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_type_response.dart';
import 'package:bps_portal_marketing/domain/core/model/contact/response/role_response.dart';
import 'package:bps_portal_marketing/presentation/home/telemarketing/contact/controllers/new.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class NewContactScreen extends GetView<NewContactController> {
  const NewContactScreen({super.key});

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
                  : () => controller.createContact(),
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
                'add-contact-text'.tr,
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
                          Expanded(
                            child: PagedListView(
                              pagingController: controller.pagingController,
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
                                  selectedColor: Pallet.info700,
                                  onTap: () {
                                    controller.type.value = item;
                                    controller.type.controller?.text =
                                        '${item.name} (${item.city}, ${item.province})';
                                    Get.back();
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    item.name,
                                    style: TextStyles.regularNormalRegular,
                                  ),
                                  subtitle: Text(
                                    '${item.city}, ${item.province}',
                                    style:
                                        TextStyles.smallNormalRegular.copyWith(
                                      color: Pallet.neutral600,
                                    ),
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
                title: 'name-text'.tr,
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
              Obx(
                () => CustomDropdownInput(
                  title: 'role-text'.tr,
                  isRequired: true,
                  validator: controller.role,
                  hint:
                      controller.isRoleLoading.isTrue ? 'loading-text'.tr : '',
                  items: controller.roles.map<DropdownMenuItem>(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        value.name,
                        style: TextStyles.regularNormalRegular,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    var role = value as RoleResponse;
                    controller.role.value = role;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
