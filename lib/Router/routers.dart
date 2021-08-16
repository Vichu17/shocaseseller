import 'dart:js';

import 'package:flutter/material.dart';
import 'package:shocase/pages/authPage.dart';
import 'package:shocase/pages/dashboard_page.dart';
import 'package:shocase/pages/enter_pincode.dart';
import 'package:shocase/pages/google_map.dart';
import 'package:shocase/pages/location_button_page.dart';
import 'package:shocase/pages/login_page.dart';
import 'package:shocase/pages/signup_page.dart';
import 'package:shocase/subpages/cartPage.dart';
import 'package:shocase/subpages/emailVerification.dart';
import 'package:shocase/subpages/ordersPage.dart';
import 'package:shocase/subpages/productDetailPage.dart';
import 'package:shocase/subpages/reset-password.dart';
import 'package:shocase/subpages/seeAllProducts.dart';

final Map<String, WidgetBuilder> routes = {
  LocationButton.routeName: (context) => LocationButton(),
  pincodePage.routeName: (context) => pincodePage(),
  // LoginPage.routeName:(context) =>LoginPage(),
  GoogleMaps.routeName:(context) =>GoogleMaps(),
  DashboardPage.routeName:(context) => DashboardPage(),
  // SignUpPage.routeName:(context) =>SignUpPage(),
  VerifyScreen.routeName:(context) =>VerifyScreen(),
  ResetPassword.routeName:(context)=>ResetPassword(),
  AuthScreen.routeName:(context)=>AuthScreen(),
  // ProductDetailPage.routeName: (context) => ProductDetailPage(),
  // SeeAllProducts.routeName:(context) => SeeAllProducts(),
  // CartPage.routeName:(context) =>CartPage(),
  // OrdersPage.routeName:(context) => OrdersPage(),

};
