import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDXuW0EeGu5Oc1HuAs2iW2vXCu4eXGKGzE",
            authDomain: "facial-emotion-recognit-hzywnr.firebaseapp.com",
            projectId: "facial-emotion-recognit-hzywnr",
            storageBucket: "facial-emotion-recognit-hzywnr.appspot.com",
            messagingSenderId: "996059460488",
            appId: "1:996059460488:web:3851becb1e958aef6d803d"));
  } else {
    await Firebase.initializeApp();
  }
}
