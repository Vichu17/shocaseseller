import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shocase/pages/welcome_page.dart';
import 'package:shocase/sections/authCard.dart';

import 'location_button_page.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 590),
            decoration: BoxDecoration(
              color: Color(0xFF0e2149),
            ),
            child: Image.asset(
              'assets/logo.png',
              height: 306,
              width: 306,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 450),
            child: Center(
              child: Text(
                "Welcome!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 4.0),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 330,),
            child: Text(
              'LOGIN / SIGNUP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 6,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 250),
            // height: deviceSize.height,
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: deviceSize.width > 600 ? 2 : 4,
                    child: AuthCard(),
                  ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
