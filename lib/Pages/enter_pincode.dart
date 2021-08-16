import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pincodePage extends StatefulWidget {
  static String routeName = '/pincode-page';
  // const pincodePage({Key? key}) : super(key: key);

  @override
  _pincodePageState createState() => _pincodePageState();
}

class _pincodePageState extends State<pincodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF0e2149),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            margin: EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              style: TextStyle(color: Colors.grey),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(Icons.add_location),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Pincode',
                helperText: 'Please Enter your Pincode',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
