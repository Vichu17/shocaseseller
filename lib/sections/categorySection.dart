import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String displayImage;
  final bool displyBorder;
  final double width;
  final double height;
  final bool onPressed;
  final String label;

  Avatar({
    required this.displayImage,
    this.displyBorder = true,
    this.width = 70,
    this.height = 70,
    this.onPressed = true,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4, 8),
                  blurRadius: 6,
                  spreadRadius: 1),
            ],
            border: displyBorder
                ? Border.all(
                    color: Colors.grey.shade300,
                    width: 3,
                  )
                : Border(),
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              displayImage,
              width: width,
              height: width,
            ),
          ),
        ),
        Container(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          width: 90,
          padding: EdgeInsets.only(top: 80),
        )
      ],
    );
  }
}
