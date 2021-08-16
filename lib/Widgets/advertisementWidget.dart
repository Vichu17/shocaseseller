import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shocase/assets.dart';

class AdvertismentContainer extends StatefulWidget {
  const AdvertismentContainer({Key? key}) : super(key: key);

  @override
  _AdvertismentContainerState createState() => _AdvertismentContainerState();
}

class _AdvertismentContainerState extends State<AdvertismentContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width,
       //padding: EdgeInsets.only(bottom: 100),
          child: CarouselSlider(
            items:[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover,image: ExactAssetImage(add),),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
              ),
              Container(
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover,image: ExactAssetImage(add),),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
              ),
              Container(
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover,image: ExactAssetImage(add),),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
              ),
              Container(
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover,image: ExactAssetImage(add),),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
              ),
            ],options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            initialPage: 2,
            autoPlay: true,
          ), ),
        );
  }
}
