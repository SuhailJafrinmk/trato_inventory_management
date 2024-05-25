
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return OnBoardingSlider(
      centerBackground: true,
      onFinish: () {
        Navigator.pushReplacementNamed(context, 'login');
      },
      headerBackgroundColor: Colors.white,
      finishButtonText: 'Register',
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: AppColors.primaryColor,
      ),
      skipTextButton: const Text('Skip'),
      trailing: const Text('Login'),
      background: [
        SizedBox(
          width: screenWidth,
          height: screenHeight*.4,
          child: SvgPicture.asset('assets/images/added_latest_inventory_svg.svg'),
        ),
        SizedBox(
          width: screenWidth,
          height: screenHeight*.4,
          child: SvgPicture.asset('assets/images/inventory_management_vector.svg'),
        ),
      ],
      totalPage: 2,
      speed: 1.8,
      pageBodies: [
        Container(
          height: screenHeight,
          width: screenWidth,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const Expanded(
                flex: 6,
                child: SizedBox()),
              Expanded(
                flex: 3,
                child: Container(
             
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                        //  color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60),bottomRight: Radius.circular(60))
                  ),
                  // height: screenHeight,
                  // width: screenWidth,
                  child: Center(
                    child: Column(
                      children: [
                        AutoSizeText('Streamline Your Inventory Management with Ease',style: onboardingTitle,textAlign: TextAlign.left,),
                        SizedBox(height: screenHeight*.01,),
                        AutoSizeText(
                          'Add and manage your inventory effortlessly. Our intuitive interface lets you quickly input and update stock levels, item details, and categories.',
                          style: onboardingDescriptionText,
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          height: screenHeight,
          width: screenWidth,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const Expanded(
                flex: 4,
                child: SizedBox()),
              Expanded(
                flex: 3,
                child: Container(
             
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                        //  color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60),bottomRight: Radius.circular(60))
                  ),
                  // height: screenHeight,
                  // width: screenWidth,
                  child: Center(
                    child: Column(
                      children: [
                        AutoSizeText('Effortless Inventory and Order Management with Trato',style: onboardingTitle,textAlign: TextAlign.left,),
                        SizedBox(height: screenHeight*.01,),
                        AutoSizeText(
                          'Streamline your inventory management with ease. Trato helps you keep track of your stock, manage orders, and gain insights into your business operations. Let\'s get started!',
                          style: onboardingDescriptionText,
                          // textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
       
      ],
    );
  }
}
