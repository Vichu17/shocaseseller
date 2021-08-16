import 'dart:async';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shocase/Providers/auth.dart';
import 'package:shocase/Providers/cart.dart';
import 'package:shocase/Providers/orders.dart';
import 'package:shocase/Providers/productsProvider.dart';
import 'package:shocase/Services/userManagement.dart';
import 'package:shocase/Widgets/productItem.dart';
import 'package:shocase/pages/authPage.dart';
import 'package:shocase/pages/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'package:shocase/pages/signup_page.dart';
import 'package:shocase/pages/splash_screen.dart';
import 'package:shocase/pages/welcome_page.dart';
import 'package:shocase/subpages/cartPage.dart';
import 'package:shocase/subpages/editProductPage.dart';
import 'package:shocase/subpages/emailVerification.dart';
import 'package:shocase/subpages/ordersPage.dart';
import 'package:shocase/subpages/productDetailPage.dart';
import 'package:shocase/subpages/seeAllProducts.dart';
import 'package:shocase/subpages/userProductPage.dart';

import 'Providers/product.dart';
import 'Widgets/bottomNavigation.dart';
import 'Widgets/side_drawer.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  // These two lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (context) => ProductsProvider("", "", []),
          update: (context, auth, previousProductsProvider) => ProductsProvider(
              auth.token.toString(),
              auth.userId.toString(),
              previousProductsProvider == null
                  ? []
                  : previousProductsProvider.items),
        ),
        ChangeNotifierProvider(
          // value: ProductsProvider(),
          create: (context) => UserManagement(),
        ),
        ChangeNotifierProvider(
          // value: ProductsProvider(),
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders("", "", []),
          update: (context, auth, previousOrders) => Orders(
              auth.token.toString(),
              auth.userId.toString(),
              previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          // home: WelcomePage(),
          home: auth.isAuth
              ? MainPage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            MainPage.routeName: (context) => MainPage(),
            VerifyScreen.routeName: (context) => VerifyScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
            ProductDetailPage.routeName: (context) => ProductDetailPage(),
            CartPage.routeName: (context) => CartPage(),
            OrdersPage.routeName: (context) => OrdersPage(),
            SeeAllProducts.routeName: (context) => SeeAllProducts(),
            UserProductPage.routName: (context) => UserProductPage(),
            EditProductPage.routeName: (context) => EditProductPage(),
          },
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  static const routeName = '/mainpage';

  // final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;
  int selectedIndex = 0;
  List<Widget> listWidgets = [DashboardPage(), SeeAllProducts(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   backgroundColor: Colors.teal,
      // ),
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
            onPressed: () {
              showNotification();
            },
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: listWidgets[selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color(0xFF0e2149),
        items: [
          TabItem(
            icon: Icons.home_outlined,
          ),
          TabItem(
            icon: Icons.compare_arrows,
            title: 'Compare',
          ),
          TabItem(
            icon: Icons.add_shopping_cart,
          ),
        ],
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
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
}
