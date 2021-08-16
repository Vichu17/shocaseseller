import 'package:flutter/material.dart';
class TextContainer extends StatelessWidget {
  final String label;
  TextContainer({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Text(
        label != null ? label : "N/A",
        style: TextStyle(
          letterSpacing: 2,
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }
}
