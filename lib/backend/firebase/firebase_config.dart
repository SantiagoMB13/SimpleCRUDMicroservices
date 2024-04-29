import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBwk2nhVpdAhcSwZ5PpR-0PbzNb7txJrBg",
            authDomain: "crud-db-e2974.firebaseapp.com",
            projectId: "crud-db-e2974",
            storageBucket: "crud-db-e2974.appspot.com",
            messagingSenderId: "393256890589",
            appId: "1:393256890589:web:0dc78ec2ed1f06acfdeb34",
            measurementId: "G-VELQ4JP0HB"));
  } else {
    await Firebase.initializeApp();
  }
}
