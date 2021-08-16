// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shocase/pages/dashboard_page.dart';
// import 'package:shocase/pages/welcome_page.dart';
// import 'package:shocase/subpages/reset-password.dart';
//
// import '../main.dart';
//
// enum AuthMode { Signup, Login }
//
// class LoginPage extends StatefulWidget {
//   // const LoginPage({Key? key}) : super(key: key);
//   static String routeName = '/login-page';
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _auth = FirebaseAuth.instance;
//   late User loggedUser;
//   late String email;
//   late String password;
//
//   final GlobalKey<FormState> _formKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: <Widget>[
//           Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(bottom: 500),
//             decoration: BoxDecoration(
//               color: Color(0xFF0e2149),
//             ),
//             child: Image.asset(
//               'assets/logo.png',
//               height: 306,
//               width: 306,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(bottom: 350),
//             child: Center(
//                 child: Text(
//               'LOGIN',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 letterSpacing: 6,
//                 fontWeight: FontWeight.w300,
//               ),
//             )),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 250.0, left: 10.0, right: 10.0),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: Container(
//                 height: 300,
//                 width: 360,
//                 child: Form(
//                   key: _formKey,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.only(top: 10.0),
//                           child: Text(
//                             'Please enter your Personal Info',
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         Container(
//                           width: 300,
//                           child: TextField(
//                             onChanged: (value) {
//                               email = value;
//                             },
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.grey[200],
//                               hintText: 'Email',
//                               hintStyle: TextStyle(color: Colors.grey[400]),
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: 10.0, horizontal: 20.0),
//                               border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(32.0)),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 8.0,
//                         ),
//                         Container(
//                           width: 300,
//                           child: TextField(
//                             onChanged: (value) {
//                               password = value;
//                             },
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.grey[200],
//                               hintText: 'Password',
//                               hintStyle: TextStyle(color: Colors.grey[400]),
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: 10.0, horizontal: 20.0),
//                               border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(32.0)),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30.0,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(vertical: 1.0),
//                           child: Material(
//                             color: Color(0xFF0e2149),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)),
//                             child: MaterialButton(
//                               onPressed: () async {
//                                 try {
//                                   final user =
//                                       await _auth.signInWithEmailAndPassword(
//                                           email: email, password: password);
//                                   if (user != null) {
//                                     Navigator.pushAndRemoveUntil(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => MainPage()),
//                                         (route) => false);
//                                   }
//                                 } catch (e) {
//                                   Fluttertoast.showToast(
//                                       msg:
//                                           "Please check you Email and Password",
//                                       toastLength: Toast.LENGTH_LONG,
//                                       gravity: ToastGravity.CENTER,
//                                       backgroundColor: Colors.white,
//                                       textColor: Colors.black);
//                                 }
//                               },
//                               minWidth: 300.0,
//                               height: 20.0,
//                               child: Text(
//                                 'SignIn',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           child: TextButton(
//                             child: Text('Forget Password?'),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ResetPassword(),
//                                 ),
//                               );
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
