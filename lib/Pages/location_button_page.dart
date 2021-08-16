import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shocase/pages/enter_pincode.dart';
import 'package:shocase/pages/google_map.dart';

class LocationButton extends StatelessWidget {
  static String routeName = '/location-button';

  void getLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0e2149),
        body: Stack(
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                padding: EdgeInsets.only(bottom: 300),
                child: Center(
                  child: Image.asset("assets/logo.png",height: 306,width: 306,),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 160),
              child: Center(
                child: Image.asset("assets/map.png"),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 320),
              child: Center(
                child: Text(
                  "Please Share Your Delivery Location",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 430),
              child: Center(
                child: FlatButton(
                  onPressed: () {
                    getLocation();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMaps(),
                      ),
                    );
                  },
                  child: Text(
                    "USE MY CURRENT LOCATION",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  color: Colors.white,
                  textColor: Color(0xFF0e2149),
                  shape: StadiumBorder(),
                  padding: EdgeInsets.all(10),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 550, right: 100),
              child: Center(
                child: Text(
                  "Know your location?",
                  style: TextStyle(color: Colors.white, wordSpacing: 4),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 550, left: 135),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pincodePage(),
                      ),
                    );
                  },
                  child: Text(
                    "Enter Pincode",
                    style: TextStyle(
                      color: Color(0xFF00ffcc),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
