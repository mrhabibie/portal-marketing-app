import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';

enum FilterDateEnum { today, last7days, last30days, last90days, custom }

final Map<FilterDateEnum, String> filterDateNumberString = {
  FilterDateEnum.last7days: '7',
  FilterDateEnum.last30days: '30',
  FilterDateEnum.last90days: '90',
};

final Map<FilterDateEnum, String> filterDateString = {
  FilterDateEnum.today: 'today-text'.tr,
  FilterDateEnum.last7days: 'last-n-days-text'.trParams({
    'number': '7',
  }),
  FilterDateEnum.last30days: 'last-n-days-text'.trParams({
    'number': '30',
  }),
  FilterDateEnum.last90days: 'last-n-days-text'.trParams({
    'number': '90',
  }),
  FilterDateEnum.custom: 'custom-text'.tr,
};

enum ContactStatus { potential, normal, notPotential }

final Map<ContactStatus, String> contactStatus = {
  ContactStatus.potential: 'potential-text'.tr,
  ContactStatus.normal: 'n-a-text'.tr,
  ContactStatus.notPotential: 'not-potential-text'.tr,
};

final Map<int, String> contactStatusInitial = {
  1: 'P',
  0: '-',
  -1: 'N',
};

final Map<int, Color> contactStatusColor = {
  1: Pallet.success700,
  0: Pallet.neutral600,
  -1: Pallet.danger700,
};

final Map<int, Color> contactStatusBgColor = {
  1: Pallet.success50,
  0: Pallet.neutral100,
  -1: Pallet.danger100,
};

enum PhotoDirEnum { DCIM, APP_DATA }
