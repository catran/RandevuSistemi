import 'package:chat_application/home_screen.dart';
import 'package:chat_application/profile/profile_screen.dart';
import 'package:chat_application/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';
import 'environments/integration.dart' as env;

String _profilad = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  env.main();
  runApp(MyApp());
}

dynamic loginUserName = "Cansu Cavuldak";
dynamic hakkimda1 = "Hakkımdaaaa";

class MyApp extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: SafeArea(
        child: Home(),
      ),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        AuthScreen.routeName: (_) => AuthScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
