import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:shocase/pages/authPage.dart';
import 'package:shocase/pages/signup_page.dart';

class GoogleMaps extends StatefulWidget {
  static String routeName = '/google-map';
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final _firestore = FirebaseFirestore.instance;
  late GoogleMapController mapController;
  late String searchAddress;
  Set<Marker> _marker = {};



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _marker,
            onMapCreated: onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(11.2588, 75.7804), zoom: 10.0),
            myLocationEnabled: true,
          ),

          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Address',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _firestore.collection('user_location').add({'user_location':searchAddress});
                      searchandNavigate();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthScreen(),
                        ),
                      );
                    },
                    iconSize: 30.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchAddress = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchandNavigate() {

    locationFromAddress(searchAddress).then(
          (result) => {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    result[0].latitude, result[0].longitude),
                zoom: 10.0),
          ),
        ),
      },
    );
  }

  void onMapCreated(controller) {
    setState(() {
      //_marker.add(Marker(markerId: MarkerId('id-1'),position:LatLng(), ),);
      mapController = controller;
    });
  }
}
