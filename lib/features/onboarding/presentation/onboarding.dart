import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Colors.black,
        ),
        skipTextButton: const Text('Skip'),
        trailing: const Text('Login'),
        background: [
          // SvgPicture.asset('assets/images/onboarding_edited_one.svg'),
          // SvgPicture.asset('assets/images/onboarding_edited_one.svg'),
          SvgPicture.asset('assets/images/Frame.svg'),
          SvgPicture.asset('assets/images/onboarding_edited_three.svg'),
          SvgPicture.asset('assets/images/Frame.svg'),
          // SvgPicture.asset('images/onboarding_edited_two.svg'),
          // SvgPicture.asset('assets/images/onboarding edited3.svg'),
          
        ],
        totalPage: 2,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 1'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Description Text 2'),
              ],
            ),
          ),
        ],
      );
  }
}