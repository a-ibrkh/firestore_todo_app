import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  ColorContainer(
      {Key? key, required this.customColor, required this.customOnTap})
      : super(key: key);
  Color customColor;
  VoidCallback customOnTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: customOnTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: customColor),
      ),
    );
  }
}
