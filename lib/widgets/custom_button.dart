import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  Widget ?child;
  double height;
  double width;
  double elevation;
  void Function()? onTap;
  double radius;
  Color color;
  CustomButton({this.child,required this.height,required this.width,required this.elevation,required this.color,this.onTap,required this.radius});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: color,
        elevation:elevation ,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}