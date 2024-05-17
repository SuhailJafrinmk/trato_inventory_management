import 'package:flutter/material.dart';
import 'package:trato_inventory_management/features/splash_screen/splash_screen.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/routes/routes.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: AppRoutes.approutes,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundColor
        )
      ),
      debugShowCheckedModeBanner: false,
     home:const SplashScreen(),
    );
  }
}