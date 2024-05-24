// import 'package:flutter/material.dart';
// import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:trato_inventory_management/utils/constants/colors.dart';
// import 'package:trato_inventory_management/utils/constants/text_styles.dart';

// class OnBoarding extends StatefulWidget {
//   @override
//   State<OnBoarding> createState() => _OnBoardingState();
// }

// class _OnBoardingState extends State<OnBoarding> {
//   @override
//   Widget build(BuildContext context) {
//       return OnBoardingSlider(
//         onFinish: (){
//           Navigator.pushReplacementNamed(context,'login');
//         },
//         headerBackgroundColor: Colors.white,
//         finishButtonText: 'Register',
//         finishButtonStyle: const FinishButtonStyle(
//           backgroundColor: AppColors.primaryColor,
//         ),
//         skipTextButton: const Text('Skip'),
//         trailing: const Text('Login'),
//         background: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: SvgPicture.asset('assets/images/added_latest_inventory_svg.svg')),
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: SvgPicture.asset('assets/images/inventory_management_vector.svg')),
//           // SvgPicture.asset('assets/images/latest_added_inventory_management.svg'),
//         ],
//         totalPage: 2,
//         speed: 1.8,
//         pageBodies: [
//           Container(
//             // color: Colors.amber,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child:  Column(
//               children: <Widget>[
//                 const SizedBox(
//                   height: 480,
//                 ),
//                 Expanded(child: Container(
//                   padding: EdgeInsets.all(10),
//                   width: MediaQuery.of(context).size.width,
//                   // color: AppColors.backgroundColor,
//                   child: Text('Add and manage your inventory effortlessly. Our intuitive interface lets you quickly input and update stock levels, item details, and categories.',style: onboardingDescriptionText,))),
//               ],
//             ),
//           ),
//           Container(
//             color: Colors.amber,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child:  Column(
//               children: <Widget>[
//                 const SizedBox(
//                   height: 480,
//                 ),
//                 Expanded(child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   // color: AppColors.backgroundColor,
//                   child: Text("Streamline your inventory management with ease. Trato helps you keep track of your stock, manage orders, and gain insights into your business operations. Let's get started!",style: onboardingDescriptionText,)))
//               ],
//             ),
//           ),
//         ],
//       );
//   }
// }
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.6),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: screenWidth,
                  child: Text(
                    'Add and manage your inventory effortlessly. Our intuitive interface lets you quickly input and update stock levels, item details, and categories.',
                    style: onboardingDescriptionText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.6),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: screenWidth,
                  child: Text(
                    "Streamline your inventory management with ease. Trato helps you keep track of your stock, manage orders, and gain insights into your business operations. Let's get started!",
                    style: onboardingDescriptionText,
                    textAlign: TextAlign.center,
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
