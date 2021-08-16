import 'dart:ui';
import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/auth.dart';
import 'package:shocase/Services/userManagement.dart';
import 'package:shocase/subpages/emailVerification.dart';
import 'package:shocase/subpages/reset-password.dart';
// import 'package:shocase/Providers/userProvider.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  // const AuthCard({
  //   Key key,
  // }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String userId;
  late String email;
  late String password;
  String? username;
  String? phone;
  late String repassword;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Size> _heightAnimation;
  final CollectionReference _usersCollectionReference = FirebaseFirestore.instance.collection("user_master");


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 310), end: Size(double.infinity, 480))
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    // _heightAnimation.addListener(() => setState((){}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An Error occurred!'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
      // 'confirmpassword':_authData,
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await _auth.signInWithEmailAndPassword(email: _authData['email']!, password: _authData['password']!);

        await Provider.of<Auth>(context, listen: false).login(
          _authData['email']!,
          _authData['password']!,
        );
        // Log user in
      } else
        {
        // await Provider.of<Auth>(context, listen: false).signup(
        //     _authData['email']!,
        //     _authData['password']!,
        //     _authData['username']!,
        //     _authData['phonenumber']!
        // );

        final newUser = await _auth
            .createUserWithEmailAndPassword(
            email: email, password: password);
        if (newUser != null) {
          await Provider.of<UserManagement>(context, listen: false).storeNewUser(context, email, username, phone,_auth.currentUser!.uid.toString(), "");


          // _usersCollectionReference.doc(_auth.currentUser!.uid.toString())
          //     .set({
          //   'user_email': email,
          //   'user_name': username,
          //   'user_id': _auth.currentUser!.uid.toString(),
          //   'user_mobile': phone,
          // });

          // await Provider.of<Auth>(context, listen: false).signup();
          // Navigator.pushReplacementNamed(context, VerifyScreen.routeName);
            // Sign user up
        }
      }
    } catch (error) {
      String errorMessage = 'Could not Authenticate you. Please try again later.';
      if (error.toString().contains('email-already-in-use')) {
        errorMessage = 'This Email Address already Registered';
        _showErrorDialog(errorMessage);
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
        _showErrorDialog(errorMessage);
      } else if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This Email Address already Registered';
        _showErrorDialog(errorMessage);
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a Valid Email Address';
        _showErrorDialog(errorMessage);
      } else if (error.toString().contains('weak-password')) {
        errorMessage = 'This password is too Weak';
        _showErrorDialog(errorMessage);
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email';
        _showErrorDialog(errorMessage);
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
        _showErrorDialog(errorMessage);
      } else {
        _showErrorDialog(error.toString());
      }

    }

    setState(() {
      _isLoading = false;
    });

  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // height: 450,
      // padding: EdgeInsets.only(top: 50),
      child: AnimatedBuilder(
        animation: _heightAnimation,
        builder: (context, ch) => Container(
            // height: _authMode == AuthMode.Signup ? 320 : 260,
            height: _heightAnimation.value.height,
            // color: Colors.white,

            constraints:
                // BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
                BoxConstraints(
              minHeight: _heightAnimation.value.height,
            ),
            width: deviceSize.width * 0.90,
            padding: EdgeInsets.all(13.0),
            child: ch),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'User name',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('')) {
                        return 'Invalid username!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      username = value;
                    },
                    onSaved: (value) {
                      _authData['username'] = value!;
                    },
                  ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                    return null;
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  SizedBox(
                    height: 15.0,
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('')) {
                        return 'Invalid Phone number!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      phone = value;
                    },
                    onSaved: (value) {
                      _authData['phonenumber'] = value!;
                    },
                  ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 5,
                ),
                if (_authMode == AuthMode.Signup)
                  Container(
                    child: CheckboxListTileFormField(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('I accept the terms of the agreements',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      activeColor: Color(0xFF0e2149),
                      onSaved: (bool value){},
                      validator: (bool value) {
                        if (value) {
                          return null;
                        } else {
                          return 'Please Accept the terms and conditions to sign up.';
                        }
                      },
                      // value: _isChecked,
                      // onChanged: (value) {
                      //   setState(() {
                      //     _isChecked = value!;
                      //   });
                      // },
                    ),
                  ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 100.0, vertical: 8.0),
                    color: Color(0xFF0e2149),
                    textColor: Theme.of(context).primaryTextTheme.button!.color,
                  ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_authMode == AuthMode.Login)
                        Container(
                          child: Text('Don\'t Have an Account?'),
                        ),
                      FlatButton(
                        child: Text(
                            '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                        onPressed: _switchAuthMode,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textColor: Color(0xFF0e2149),
                      ),
                    ],
                  ),
                ),
                if (_authMode == AuthMode.Login)
                  Container(
                    child: TextButton(
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Color.fromARGB(221, 0, 255, 204),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPassword(),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
