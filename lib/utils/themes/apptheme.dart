import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

enum themes{
  darktheme,
  lighttheme,
}
class AppThemes{
final themeList={
  themes.darktheme:ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
  )
  
};

}