import 'package:cloud_firestore/cloud_firestore.dart';

class Collections {
  static CollectionReference<Map<String, dynamic>> category() {
    return FirebaseFirestore.instance.collection("category");
  }

  static CollectionReference<Map<String, dynamic>> dish() {
    return FirebaseFirestore.instance.collection("dish");
  }
}
