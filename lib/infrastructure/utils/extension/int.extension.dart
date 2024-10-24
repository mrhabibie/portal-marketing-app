import 'package:intl/intl.dart';

extension IntExtension on int {
  String get toIdr => NumberFormat.currency(
        locale: 'id_ID',
        symbol: '',
        decimalDigits: 0,
      ).format(this);

  String get toRupiah => NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp',
        decimalDigits: 0,
      ).format(this);

  String get toDollar => NumberFormat.currency(
        locale: 'en_US',
        symbol: '\$',
        decimalDigits: 0,
      ).format(this);
}
