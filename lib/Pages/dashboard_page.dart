import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shocase/Widgets/advertisementWidget.dart';
import 'package:shocase/Widgets/bottomNavigation.dart';
import 'package:shocase/subpages/ordersPage.dart';
import 'package:shocase/Widgets/side_drawer.dart';
import 'package:shocase/icons.dart';
import 'package:shocase/Widgets/productOverviewPage.dart';
import 'package:shocase/sections/categorySection.dart';
import 'package:shocase/sections/headerSection.dart';
import 'package:shocase/Widgets/categoryWidget.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:shocase/sections/bannerAdvertis.dart';
import 'package:shocase/subpages/seeAllProducts.dart';
import '../assets.dart';
import '../main.dart';

class DashboardPage extends StatefulWidget {
  static String routeName = '/dashboard';

  // const DashboardPage({Key key, this.title}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _counter = 0;
  final _auth = FirebaseAuth.instance;
  late User loggedUser;

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
    // print("Current User");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ListView(
          children: <Widget>[
            HeaderSection(),
            // CategoryWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest Products',
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeeAllProducts(),
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            Container(
              height: 400,
              child: ProductsOverviewPage(),
            ),
            Container(
              height: 230,
              child: BannerAdvertise(),
            ),
            Container(
              height: 400,
              child: ProductsOverviewPage(),
            ),
            AdvertismentContainer(),
            // Container(
            //   color: Colors.white,
            //   height: 440,
            //   child: Orders(),
            // ),
          ],
        ),
      ),
    );
  }
}
