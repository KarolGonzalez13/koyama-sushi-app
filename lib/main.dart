import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference, FirebaseFirestore;
import 'package:flutter/material.dart';
import 'home_page.dart'; // Importamos el nuevo archivo
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());

  FirebaseFirestore db = FirebaseFirestore.instance;

  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };

  db.collection("users")
    .add(user)
    .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // Referencia a la nueva clase HomePage
    );
  }
}
