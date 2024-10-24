import 'package:flutter_contacts/flutter_contacts.dart';

import '../helpers/helper.dart';

class ContactService {
  static final ContactService to = ContactService._singleTon();

  factory ContactService() {
    return to;
  }

  ContactService._singleTon();

  Future<void> init() async {
    await FlutterContacts.requestPermission();

    _contactListener();
  }

  Future<List<Contact>> getContacts() async {
    return await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: true,
      withThumbnail: true,
      deduplicateProperties: true,
      withAccounts: true,
      withGroups: true,
    );
  }

  Future<void> _contactListener() async {
    FlutterContacts.addListener(() {
      log.d('${DateTime.now().toIso8601String()} ==> Contact DB changed');
    });
  }
}
