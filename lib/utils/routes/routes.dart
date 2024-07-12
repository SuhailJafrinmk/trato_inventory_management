
import 'package:flutter/material.dart';
import 'package:trato_inventory_management/features/addproduct/presentation/add_product.dart';
import 'package:trato_inventory_management/features/addpurchase/presentation/screens/add_purchase.dart';
import 'package:trato_inventory_management/features/home_screen/presentation/screens/home_screen.dart';
import 'package:trato_inventory_management/features/login/presentation/screens/login_screen.dart';
import 'package:trato_inventory_management/features/onboarding/presentation/onboarding.dart';
import 'package:trato_inventory_management/features/profile/presentation/profile_page.dart';
import 'package:trato_inventory_management/features/purchases/presentation/screens/purchases.dart';
import 'package:trato_inventory_management/features/records/presentation/records.dart';
import 'package:trato_inventory_management/features/register/presentation/signup.dart';
import 'package:trato_inventory_management/features/splash_screen/splash_screen.dart';

class AppRoutes{
  static Map<String,WidgetBuilder> approutes={
  'splash_screen':(context) => const SplashScreen(),
  'onboarding':(context) => OnBoarding(),
  'login':(context)=>const LoginScreen(),
  'signup':(context)=>const SignupScreen(),
  'home_screen':(context) => const HomeScreen(),
  'add_product':(context) => AddProduct(),
  'add_purchase':(context) => const AddPurchase(),
  'records':(context) => const Records(),
  'profile_screen':(context) => ProfileScreen(),
  'purchase_page':(context) => PurchasesList(),
  };
}