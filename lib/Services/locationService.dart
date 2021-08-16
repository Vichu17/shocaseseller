// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// class LocationService extends StatefulWidget {
//   @override
//   _LocationService createState() => _LocationService();
//
// }
//
//
//
// class _LocationService extends State<LocationService> {
//   // final Geolocator geolocator = Geolocator();
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   late Position _currentPosition;
//   late String _currentAddress;
//
//   Position? get currentPostion(){
//     return _currentPosition;
//   }
//
//   _getCurrentLocation() {
//     Geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
