import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shocase/Widgets/advertisementWidget.dart';
import 'package:shocase/Widgets/categoryWidget.dart';
import 'package:shocase/assets.dart';
import 'package:shocase/subpages/seeAllProducts.dart';

enum FilterOption {
  Favorites,
}

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  Position? _currentPosition;
  String? _currentAddress;

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            // forceAndroidLocationManager: true)
    )
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print("Current Position : " + _currentPosition!.latitude.toString() + "," +_currentPosition!.longitude.toString());
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.subLocality},${place.postalCode},${place.locality}";
        print("Current Address : " + _currentAddress!);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      // width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              alignment: Alignment.topCenter,
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(80),
                  bottomLeft: Radius.circular(80),
                ),
                color: Color(0xFF0e2149),
              ),
            ),
          ),
          Positioned(
            child: Container(
              alignment: Alignment.topCenter,
              child: TextButton.icon(
                onPressed: () {
                  _getCurrentLocation();
                },
                icon: Icon(
                  Icons.location_searching,
                  color: Colors.white,
                ),
                label: _currentAddress != null
                    ? Text(_currentAddress.toString(),
                        style: TextStyle(color: Colors.white))
                    : Text("Awaiting Location",
                        style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          Positioned(
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 50),
              // margin: EdgeInsets.only(top: 20),
              child: Image.asset(
                headerlogo,
                width: 250,
              ),
            ),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 120),
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {}, //Navigate to page Shops
                      child: Text(
                        'Shops',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllProducts(),
                          ),
                        );
                      }, //Navigate to page Products
                      child: Text('Products',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {}, //Navigate to page Feeds
                      child: Text('Feeds',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {}, //Navigate to page Favorites
                      child: Text('Favorite',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
                padding: EdgeInsets.only(top: 180),
                child: AdvertismentContainer()),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 380),
              child: CategoryWidget(),
            ),
          )
        ],
      ),
    );
  }
}
