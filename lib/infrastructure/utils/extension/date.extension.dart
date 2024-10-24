import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get toIdDate =>
      DateFormat.yMMMMEEEEd(Get.locale?.toLanguageTag()).format(this);

  String get toIdDateOnly =>
      DateFormat.yMMMMd(Get.locale?.toLanguageTag()).format(this);

  String get toIdDay =>
      DateFormat.EEEE(Get.locale?.toLanguageTag()).format(this);

  String get toIdDateTime => DateFormat.yMMMMEEEEd(Get.locale?.toLanguageTag())
      .add_Hms()
      .format(this)
      .replaceAll('.', ':');

  String get toDate {
    return toString().split(' ')[0];
  }
}
