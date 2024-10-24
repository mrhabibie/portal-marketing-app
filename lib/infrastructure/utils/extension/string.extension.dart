extension StringExtension on String {
  String get formatPhoneNumber => replaceAllMapped(
      RegExp(r'(\d{2})(\d{3})(\d{4})(\d+)'),
      (m) => "+${m[1]} ${m[2]}-${m[3]}-${m[4]}");
}
