import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:price_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:price_app/pages/loginPage.dart';
import 'package:price_app/pages/mainPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: config.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: FirebaseAuth.instance.currentUser(),
    //   builder: );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: mainApp(),
    );
  }
}

class mainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return mainPage();
          } else if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Something Went Wrong. Try Login Again!')));
            return loginPage();
          } else {
            return loginPage();
          }
        },
      ),
    );
  }
}
