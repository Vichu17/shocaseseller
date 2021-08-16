import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/auth.dart';
import 'package:shocase/Providers/productsProvider.dart';
import 'package:shocase/main.dart';

import 'package:shocase/sections/authCard.dart';

class VerifyScreen extends StatefulWidget {
  // const VerifyScreen({Key? key}) : super(key: key);
  static String routeName = '/verify-email';


  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _firestore = FirebaseFirestore.instance;
  late String email;
  late String password;
  late String username;
  late String phone;
  late String repassword;
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0e2149),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An Email has been send to ${user.email} \n Please Verify you email to continue Login',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          CircularProgressIndicator(
            backgroundColor: Color(0xFF0e2149),
            strokeWidth: 5,
          )
        ],
      )),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      // Navigator.of(context).pop();
      // Navigator.of(context).pushReplacementNamed('/');
      // Navigator.of(context).pushNamed('/');

      // Navigator.of(context).pushNamed(MainPage.routeName);
      print("User ID Post SignUP : " + user.uid.toString());
      print("Verified");

      // runApp(MyApp());
      // MyApp();
      // await Provider.of<ProductsProvider>(context, listen: false).addFetchSetProducts(true);
      Navigator.of(context).pushReplacementNamed('/');
      Fluttertoast.showToast(
          msg: 'Signup Successful, Please Login To Continue',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xFF0e2149),
          textColor: Colors.white
      );
    }
    print("User EMail Post SignUP : " + auth.currentUser!.email.toString());
  }
}
