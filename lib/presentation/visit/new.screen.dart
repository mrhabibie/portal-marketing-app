import 'package:bps_portal_marketing/domain/core/model/contact/response/contact_type_response.dart';
import 'package:bps_portal_marketing/presentation/visit/controllers/new.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../../infrastructure/widgets/widgets.dart';

class NewVisitScreen extends GetView<NewVisitController> {
  const NewVisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.neutralWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.purple,
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
                  : () => controller.createVisit(),
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
          padding: EdgeInsets.all(AppDimension.style20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'add-visit-text'.tr,
                style: TextStyles.largeNormalBold,
              ),
              SizedBox(height: AppDimension.height20),
              CustomTextInput(
                title: 'group-text'.tr,
                isNeedSearch: false,
                isNeedClear: false,
                isRequired: true,
                isNeedDropdown: true,
                isReadOnly: true,
                validator: controller.idContactType,
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
                                    controller.idContactType.value = item;
                                    controller.idContactType.controller?.text =
                                        '${item.name} (${item.city}, ${item.province})';
                                    Navigator.of(Get.overlayContext!).pop();
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
              SizedBox(height: AppDimension.height10),
              CustomTextInput(
                title: 'sales-1-text'.tr,
                isRequired: true,
                validator: controller.idSales1,
                onChanged: (value) {},
              ),
              SizedBox(height: AppDimension.height10),
              CustomTextInput(
                title: 'sales-2-text'.tr,
                isRequired: true,
                validator: controller.idSales2,
                onChanged: (value) {},
              ),
              SizedBox(height: AppDimension.height10),
              CustomTextInput(
                title: 'visit-date-text'.tr,
                isNeedSearch: false,
                isNeedClear: false,
                isRequired: true,
                isNeedDropdown: true,
                isReadOnly: true,
                validator: controller.visitAt,
                onChanged: (value) {},
                onTap: () => controller.chooseDate(),
              ),
              SizedBox(height: AppDimension.height10),
              CustomTextInput(
                title: 'note-field-text'.tr,
                isExpanded: true,
                validator: controller.note,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
