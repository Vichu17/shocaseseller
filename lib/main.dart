import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shocaseseller/Pages/dashboardPage.dart';
import 'package:shocaseseller/Pages/loginPage.dart';
import 'package:shocaseseller/Pages/signupPage.dart';
import 'package:shocaseseller/Pages/welcomePage.dart';

void main() async {
  // These two lines
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
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
