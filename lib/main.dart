import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shocaseseller/Pages/dashboardPage.dart';
import 'package:shocaseseller/Pages/loginPage.dart';
import 'package:shocaseseller/Pages/signupPage.dart';
import 'package:shocaseseller/Pages/welcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // These two lines
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPageSeller(),
      routes:{
        //'/': (context) => WelcomePage(),
         '/signup':(context) => SignUpPage(),
         '/login':(context) => LoginPage(),
         '/dashboard' :(context) => DashboardPageSeller(),
        // '/signup' :(context) => SignUpPage(),
        // '/login' :(context) =>LoginPage(),
        // '/dashboard':(context)=>DashboardPage(),
        // '/profile' : (context)=>ProfileScreen(),
      },
    );
  }
}
