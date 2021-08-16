import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shocase/assets.dart';

class BannerAdvertise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 230,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: 130,
            left: 20,
            right: 20,
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.pinkAccent,
                    Colors.blue,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 25),
              child:
              TextButton.icon(
                onPressed: () {
                  print('print location');
                },
                icon: Icon(Icons.location_on_outlined,color: Colors.white,size: 25,),
                label: Text('Explore nearest stores',style: TextStyle(color: Colors.white,fontSize: 20),),
              ),
            ),
          ),
          Container(
            //alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: 20,right: 20),
            height: 160,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image:
              DecorationImage(image: AssetImage(add), fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
