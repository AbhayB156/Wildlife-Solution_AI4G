// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_solution/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wildlife_solution/services/auth.dart';
import 'package:wildlife_solution/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC5FY2PINNIFpTRnRlorTtqrqFcCiVjtPY",
      appId: "1:912188807938:android:bc45f6d34f3ecbe29a001b",
      messagingSenderId: "Messaging sender id here",
      projectId: "wildlife-solution",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usr?>.value(
      initialData: Usr(uid: ''),
      value: AuthService().user,
        child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
