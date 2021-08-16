import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/auth.dart';
import 'package:shocase/Widgets/profile_pic.dart';
import 'package:shocase/subpages/deals.dart';
import 'package:shocase/subpages/myProfile.dart';
import 'package:shocase/subpages/ordersPage.dart';
import 'package:shocase/subpages/seeAllProducts.dart';
import 'package:shocase/subpages/storeNearBy.dart';
import 'package:shocase/subpages/userProductPage.dart';
import 'package:shocase/subpages/wishList.dart';
import '../icons.dart';
import 'package:shocase/Services/locationService.dart';

class SideDrawer extends StatefulWidget {
  // const SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String loggedUser = "";
  Position? _currentPosition;
  String? _currentAddress;
  String? profilePicUrl;

  // _getCurrentLocation() {
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //       _getAddressFromLatLng();
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
  //
  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         _currentPosition!.latitude, _currentPosition!.longitude);
  //
  //     Placemark place = placemarks[0];
  //
  //     setState(() {
  //       _currentAddress = "${place.subLocality}, ${place.locality}";
  //       print("Current Address : " + _currentAddress!);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<String> getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user == null) {
      loggedUser = "User";
    } else {
      loggedUser = user.email.toString();
    }
    return loggedUser;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser().then((String result) {
      setState(() {
        if(_auth.currentUser!.photoURL == null){
          profilePicUrl = "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png";
        } else {
          profilePicUrl = _auth.currentUser!.photoURL.toString();
        }
        loggedUser = result;
      });
    });
    // _getCurrentLocation();
    // if(_auth.currentUser!.photoURL == null){
    //   profilePicUrl = "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png";
    // } else {
    //   profilePicUrl = _auth.currentUser!.photoURL.toString();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 140,
            child: DrawerHeader(
              padding: EdgeInsets.only(left: 5.0),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            maxRadius: 40,
                            // backgroundImage: NetworkImage(_auth.currentUser!.photoURL.toString()),
                            backgroundImage: NetworkImage(profilePicUrl.toString()),
                          ),
                          // FutureBuilder(
                          //   future: Provider.of(context).auth.getCurrentUserId(),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState == ConnectionState.done) {
                          //       return Text("${snapshot.data}");
                          //     } else {
                          //       return CircularProgressIndicator();
                          //     }
                          //   },
                          // ),
                          // StreamBuilder(
                          //   stream : FirebaseFirestore.instance.collection('user_master').doc(_auth.currentUser!.uid).snapshots(),
                          //   builder: (context,snapshot){
                          //     if(snapshot.hasData){
                          //       return Text("");
                          //     }
                          //   }
                          // ),
                          Column(
                            children: [
                              StreamBuilder(
                                  stream: _firestore
                                      .collection('user_master')
                                      .doc(_auth.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (!snapshot.hasData) {
                                      return new Text("Loading");
                                    }
                                    var userDocument = snapshot.data;
                                    return new Text(
                                      userDocument!["user_name"],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25.0),
                                    );
                                  }),
                              Text(
                                loggedUser,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              // TextButton.icon(
                              //   onPressed: () {},
                              //   icon: Icon(
                              //     Icons.location_pin,
                              //     color: Colors.white,
                              //   ),
                              //   label: _currentAddress != null
                              //       ? Text(_currentAddress.toString(),
                              //           style: TextStyle(color: Colors.white))
                              //       : Text("Awaiting Location",
                              //           style: TextStyle(color: Colors.white)),
                              // ),
                              // IconButton(onPressed: (){}, icon: Icon(Icons.location_pin),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF0e2149),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.person,
                color: Colors.grey,
              ),
              title: Text(
                'MY PROFILE',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                ),
              },
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.store,
                color: Colors.grey,
              ),
              title: Text(
                'STORES NEAR',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StoreNearBy()),
                ),
              },
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.local_offer,
                color: Colors.grey,
              ),
              title: Text(
                'DEALS',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Deals()),
                ),
              },
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.grey,
              ),
              title: Text(
                'SHOPS',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () => {
                Navigator.of(context).pushNamed(SeeAllProducts.routeName),
              },
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.favorite,
                color: Colors.grey,
              ),
              title: Text(
                'WISH LIST',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () => {
                Navigator.of(context).pushNamed(OrdersPage.routeName),
              },
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.work,
                color: Colors.grey,
              ),
              title: Text(
                'SELL ON APP',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () => {
                Navigator.of(context).pushNamed(UserProductPage.routName),
              }, //need to include seller application link while clicking
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.settings,
                color: Colors.grey,
              ),
              title: Text(
                'SETTINGS',
                style: TextStyle(fontSize: 15.0),
              ),
              onTap: () => {},
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 30,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Notification Preference'),
              onTap: () => {},
            ),
          ),
          SizedBox(
            height: 30,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Help Center'),
              onTap: () => {},
            ),
          ),
          SizedBox(
            height: 30,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Privacy Policy'),
              onTap: () => {},
            ),
          ),
          SizedBox(
            height: 30,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Logout'),
              onTap: () => {
                Navigator.of(context).pop(),
                Navigator.of(context).pushReplacementNamed('/'),
                Provider.of<Auth>(context, listen: false).logout(),
              },
            ),
          ),
        ],
      ),
    );
  }
}
