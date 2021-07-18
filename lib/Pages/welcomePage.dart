import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF0e2149),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 520),
              child: Center(
                child: Text(
                  "Welcome!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 4.0),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 80),
              child: Center(
                child: Image.asset("assets/cover.png",height: 306,width: 306,),
              ),
            ),
            Hero(
              tag: 'logo',
              child: Container(
                padding: EdgeInsets.only(top: 330),
                child: Center(
                  child: Image.asset("assets/logo.png",height: 306,width: 306,),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 500),
              child: Center(
                child: OutlineButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 0.528,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.all(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 600, right: 50),
              child: Center(
                child: Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 600, left: 160),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Color.fromARGB(221, 0, 255, 204)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
