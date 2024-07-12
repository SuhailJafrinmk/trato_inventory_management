// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  Widget ?child;
  double? height;
  double ?width;
  double elevation;
  void Function()? onTap;
  double radius;
  Color color;
  CustomButton({this.child,this.height,this.width,this.elevation=10,this.color=AppColors.secondaryColor,this.onTap,this.radius=20});



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