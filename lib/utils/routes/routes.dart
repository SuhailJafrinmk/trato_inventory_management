



import 'package:flutter/material.dart';
import 'package:trato_inventory_management/features/addproduct/presentation/add_product.dart';
import 'package:trato_inventory_management/features/addstore/presentation/add_store.dart';
import 'package:trato_inventory_management/features/home_screen/presentation/home_screen.dart';
import 'package:trato_inventory_management/features/login/presentation/login_screen.dart';
import 'package:trato_inventory_management/features/onboarding/presentation/onboarding.dart';
import 'package:trato_inventory_management/features/product_details/presentation/product_details.dart';
import 'package:trato_inventory_management/features/register/presentation/signup.dart';
import 'package:trato_inventory_management/features/splash_screen/splash_screen.dart';

class AppRoutes{
  static Map<String,WidgetBuilder> approutes={
  'login':(context)=>LoginScreen(),
  'signup':(context)=>SignupScreen(),
  'product_details':(context)=>ProductDetails(),
  'add_store':(context) => AddStorePage(),
  'add_product':(context) => AddProduct(),
  'splash_screen':(context) => SplashScreen(),
  'onboarding':(context) => OnBoarding(),
  'home_screen':(context) => HomeScreen(),
  };
}