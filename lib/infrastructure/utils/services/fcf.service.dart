import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/helper.dart';

class FCFService {
  static final FCFService to = FCFService._singleTon();

  factory FCFService() {
    return to;
  }

  FCFService._singleTon();

  late final FirebaseFirestore db;

  Future<void> init() async {
    db = FirebaseFirestore.instance;

    final List<String> tokens = getCollections('fcmTokens');
    String? fcmToken = PrefHelper.to.getFcmToken();
    if (fcmToken != null) {
      if (tokens.contains(fcmToken)) {
        final Map<String, dynamic> doc = getDoc('fcmTokens', fcmToken);
        final createdAt = doc['createdAt'].toDate();
        final expiredAt = doc['expiredAt'].toDate();
        if (DateTime.now().isBefore(expiredAt) &&
            DateTime.now().difference(createdAt) >= const Duration(days: 14)) {
          setDoc(
            collectionName: 'fcmTokens',
            documentName: fcmToken,
            value: {
              'token': fcmToken,
              'createdAt': FieldValue.serverTimestamp(),
              'expiredAt': DateTime.now().add(const Duration(days: 30)),
            },
          );
        }
      } else {
        setDoc(
          collectionName: 'fcmTokens',
          documentName: fcmToken,
          value: {
            'token': fcmToken,
            'createdAt': FieldValue.serverTimestamp(),
            'expiredAt': DateTime.now().add(const Duration(days: 30)),
          },
        );
      }
    }
  }

  List<String> getCollections(String collectionName) {
    List<String> tokens = [];

    final docRef = db.collection(collectionName);
    docRef.get().then((QuerySnapshot query) {
      for (var doc in query.docs) {
        tokens.add(doc.id);
      }
    }, onError: (e) {
      log.d("Error getting collection: $e");
    });

    return tokens;
  }

  Map<String, dynamic> getDoc(String collectionName, String documentName) {
    Map<String, dynamic> doc = {};
    final docRef = db.collection(collectionName).doc(documentName);
    docRef.get().then((DocumentSnapshot snapshot) {
      doc = snapshot.data() as Map<String, dynamic>;
    }, onError: (e) {
      log.d("Error getting document: $e");
    });

    return doc;
  }

  void setDoc({
    required String collectionName,
    required String documentName,
    required Map<String, dynamic> value,
  }) =>
      db.collection(collectionName).doc(documentName).set(value);
}
