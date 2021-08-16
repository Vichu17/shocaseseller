import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shocase/pages/dashboard_page.dart';

class ResetPassword extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);
  static String routeName = '/rest-password';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _auth = FirebaseAuth.instance;
  late User loggedUser;
  late String email;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 500),
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
            padding: EdgeInsets.only(bottom: 350),
            child: Center(
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 6,
                    fontWeight: FontWeight.w300,
                  ),
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                height: 200,
                width: 360,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Please enter your email',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.0),
                          child: Material(
                            color: Color(0xFF0e2149),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            child: MaterialButton(
                              onPressed: () {
                                _auth.sendPasswordResetEmail(email: email);
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "An email has been send\n Please check you email",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black);
                              },
                              minWidth: 300.0,
                              height: 20.0,
                              child: Text(
                                'Send Request',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
