import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shocase/pages/dashboard_page.dart';
import 'package:shocase/subpages/cartPage.dart';

class BottomNavigation extends StatefulWidget {
  // const BottomNavigation({Key? key}) : super(key: key);
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // int selectedIndex = 0;
  // final listWidgets = [DashboardPage(), DashboardPage(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 50,
      child: Scaffold(
        // body: _pageOptions[selectedPage],
        // body: listWidgets[selectedIndex],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Color(0xFF0e2149),
          items: [
            TabItem(
              icon: Icons.home_outlined,
            ),
            TabItem(icon: Icons.compare_arrows, title: 'Compare',),
            TabItem(
              icon: Icons.add_shopping_cart,
            ),
          ],
          // initialActiveIndex: 0,
          // onTap: (int i) => print('click index=$i'),
          // initialActiveIndex: 0,
          // onTap: (index) {
          //   setState(() {
          //     _page = index;
          //     print(i);
          //   });
          // },
          // onTap : onItemTapped,
        ),
      ),
    );
  }

  // void onItemTapped(int index){
  //   setState(() {
  //     selectedIndex = index;
  //     print("Index : " + index.toString());
  //   });
  // }

}
