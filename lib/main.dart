import 'package:farmersapp/Screens/home_screen.dart';
import 'package:farmersapp/Screens/login_screen.dart';
import 'package:farmersapp/Screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //   apiKey: 'AIzaSyA4oXX8v5NHPX4hjLXDNeU6VxK3fTv0zhA',
  //   appId: '1:619776338973:web:7a9d4a1d341c4da3e5aaf4',
  //   messagingSenderId: '619776338973',
  //   projectId: 'farmersell-da481',
  //   authDomain: 'farmersell-da481.firebaseapp.com',
  //   storageBucket: 'farmersell-da481.appspot.com',
  //   measurementId: 'G-H5YD228XKR',
  // )
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmSell',
      theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(fontFamily: 'Solway', fontSize: 20),
                bodyText1: const TextStyle(fontFamily: 'Solway', fontSize: 10),
              ),
          primarySwatch: Colors.teal,
          fontFamily: 'Solway',
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'Solway',
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ))),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return HomeScreen();
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('${snapshot.error}'),
                  ),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
