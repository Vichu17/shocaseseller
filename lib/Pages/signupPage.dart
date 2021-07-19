import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:shocase/pages/google_map.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool value = false;
  late String selleremail;
  late String sellerpassword;
  late String sellerusername;
  late String sellerphone;
  late String sellerrepassword;



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
                  'REGISTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 6,
                    fontWeight: FontWeight.w300,
                  ),
                )),
          ),
          Container(
            padding: EdgeInsets.only(top: 230.0,left: 10.0,right: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                height: 430,
                width: 360,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Please enter your Personal Info',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          width: 300,
                          child: TextField(
                            onChanged: (value){
                              sellerusername = value;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'User name',
                              hintStyle: TextStyle(color: Colors.grey[400],fontSize:15),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value){
                              selleremail = value;
                            },
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
                          height: 8.0,
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            onChanged: (value){
                              sellerphone = value;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Phone Number',
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
                          height: 8.0,
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            onChanged: (value){
                              sellerpassword = value;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Password',
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
                          height: 8.0,
                        ),
                        Container(
                          width: 300,
                          child: TextField(
                            onChanged: (value){
                              sellerrepassword = value;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'ReEnter Password',
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
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value)=>setState(() => this.value =value!),
                            title: Text('I Accept the terms of the Agreement'),
                            value: value,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.0),
                          child: Material(
                            color: Color(0xFF0e2149),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            child: MaterialButton(
                              onPressed: () async {
                                try{
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                      email: selleremail, password: sellerpassword);
                                  if(newUser!= null){
                                    Navigator.pushNamed(context, '/login');
                                  }
                                }
                                catch (e){
                                  print(e);
                                }
                                _firestore.collection('user_master').add({
                                  'user_email':selleremail,
                                  'user_name':sellerusername,
                                  'user_password':sellerpassword,
                                  'user_mobile':sellerphone,
                                });
                              },
                              minWidth: 300.0,
                              height: 20.0,
                              child: Text(
                                'Signup',
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
