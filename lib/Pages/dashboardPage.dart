import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shocaseseller/Widgets/sideDrawer.dart';

class DashboardPageSeller extends StatefulWidget {
  // const DashboardPageSeller({Key? key}) : super(key: key);

  @override
  _DashboardPageSellerState createState() => _DashboardPageSellerState();
}

class _DashboardPageSellerState extends State<DashboardPageSeller> {
  final _auth = FirebaseAuth.instance;
  late User loggedSellerUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedSellerUser = user;
        print(loggedSellerUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Container(
            height: 40,
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Products',
                labelStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.mic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF0e2149),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ],
        ),
        drawer: SideDrawer(),
      ),
    );
  }
}
