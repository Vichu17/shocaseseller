import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../icons.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 140,
            child: DrawerHeader(
              padding: EdgeInsets.only(left: 20.0),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 80.0,
                          color: Colors.white,
                        ),
                        Text(
                          'Profile Name',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfileScreen()),
                // ),
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
              leading: Icon(Icons.add_circle_outline,
                color: Colors.grey,
              ),
              title: Text(
                'ADD NEW PRODUCT',
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
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.shopping_basket,
                color: Colors.grey,
              ),
              title: Text(
                'MY PRODUCTS',
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
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.event_note,
                color: Colors.grey,
              ),
              title: Text(
                'SALES REPORT',
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
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.star_half,
                color: Colors.grey,
              ),
              title: Text(
                'My RATING',
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
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(
                MyFlutterApp.insert_comment,
                color: Colors.grey,
              ),
              title: Text(
                'CHATS',
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
            height: 40,
            child: ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              horizontalTitleGap: 0,
              leading: Icon(Icons.settings,
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
              title: Text('Legal'),
              onTap: () => {},
            ),
          )
        ],
      ),
    );
  }
}
