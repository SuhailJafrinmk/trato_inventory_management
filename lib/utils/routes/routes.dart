
import 'package:flutter/material.dart';
import 'package:trato_inventory_management/features/addproduct/presentation/add_product.dart';
import 'package:trato_inventory_management/features/addpurchase/presentation/add_purchase.dart';
import 'package:trato_inventory_management/features/addstore/presentation/add_store.dart';
import 'package:trato_inventory_management/features/category/presentation/category_product_page.dart';
import 'package:trato_inventory_management/features/customer/presentation/customer_page.dart';
import 'package:trato_inventory_management/features/home_screen/presentation/home_screen.dart';
import 'package:trato_inventory_management/features/login/presentation/login_screen.dart';
import 'package:trato_inventory_management/features/onboarding/presentation/onboarding.dart';
import 'package:trato_inventory_management/features/product_details/presentation/product_details.dart';
import 'package:trato_inventory_management/features/profile/presentation/profile_page.dart';
import 'package:trato_inventory_management/features/purchases/presentation/purchases.dart';
import 'package:trato_inventory_management/features/records/presentation/records.dart';
import 'package:trato_inventory_management/features/register/presentation/signup.dart';
import 'package:trato_inventory_management/features/splash_screen/splash_screen.dart';

class AppRoutes{
  static Map<String,WidgetBuilder> approutes={
  'splash_screen':(context) => SplashScreen(),
  'onboarding':(context) => OnBoarding(),
  'login':(context)=>LoginScreen(),
  'signup':(context)=>SignupScreen(),
  'home_screen':(context) => HomeScreen(),
  'product_details':(context)=>ProductDetails(),
  'add_store':(context) => AddStorePage(),
  'add_product':(context) => AddProduct(),
  'add_purchase':(context) => AddPurchase(),
  'records':(context) => Records(),
  'profile_screen':(context) => ProfileScreen(),
  'customer_page':(context) => CustomerPage(),
  'purchase_page':(context) => PurchasesList(),
  'category_products':(context) => CategoryProductPage(),
  };
}