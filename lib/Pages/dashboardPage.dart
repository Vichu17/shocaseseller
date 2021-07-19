import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    return Container();
  }
}
