extension MapPrint on Map {
  String getAllString() {
    String result = '';
    forEach((key, value) {
      result += '$key: $value\n';
    });
    return result;
  }
}

extension ListPrint on List {
  String getAllList() {
    String result = '';
    forEach((element) {
      result += element;
      if (element != last) {
        result += ', ';
      }
    });
    return result;
  }
}
