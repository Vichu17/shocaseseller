import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shocase/assets.dart';
import 'package:shocase/sections/categorySection.dart';
import 'package:shocase/Widgets/textContainer.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(left: ,),
      height:120,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Avatar(displayImage: home, label: "Home Appliances",),
          Avatar(displayImage: fashion,label: "Fashion",),
          Avatar(displayImage: grocery,label: "Grocery \n Items",),
          Avatar(displayImage: electronic,label: "Electronics",),
        ],
      ),
    );
  }
}
