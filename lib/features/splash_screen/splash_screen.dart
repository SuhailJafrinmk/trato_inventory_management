import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/widgets/revealig_animation.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LeftToRightRevealAnimation(child: SizedBox(
              height: size.height*.5,
              width: size.width*.5,
              child: Image.asset('assets/images/logodesign2.png'),
            )),
          ],
        ),
      ),
    );
  }
}
void checkLoginStatus(context)async{
      SharedPreferences ?sharedPreferences=await SharedPreferences.getInstance();
      final loginStatus=sharedPreferences.getBool('loginkey');
      if(loginStatus==null){
        Future.delayed(Duration(seconds: 3),(){
          Navigator.pushReplacementNamed(context, 'onboarding');
        });
      }else{
        loginStatus==true ? Navigator.pushReplacementNamed(context, 'home_screen') : Navigator.pushReplacementNamed(context, 'login');
      }
  }