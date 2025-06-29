import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, FirebaseFirestore;
import 'package:flutter/material.dart';
import 'ui/home_page/_main.dart'; // Importamos el nuevo archivo
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // final user = <String, dynamic>{
  //   "first": "Ada",
  //   "last": "Lovelace",
  //   "born": 1815,
  // };

  // db
  //     .collection("users")
  //     .add(user)
  //     .then(
  //       (DocumentReference doc) =>
  //           print('DocumentSnapshot added with ID: ${doc.id}'),
  //     );

  runApp(const MainApp());
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
