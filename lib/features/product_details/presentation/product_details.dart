

import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';


class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body:  Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.backgroundColor,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  width: size.width*.92,
                  height: size.height*.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ), 
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Container(
                      height: size.height*.4,
                      width: size.width*.75,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/samsung galaxy s24.jpg'))
                      ),
                     ),
                     Expanded(
                       child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Samsung galaxy',style: productTitle,),
                            Text('Purchase price:70000',style: productDescription,),
                            Text('Selling price:100000',style: productDescription,),
                            Text('Available 8 units',style: productDescription,),
                            SizedBox(height: size.height*.02,),
                            CustomButton(height: size.height*.075, width: size.width*.7, elevation: 5, color: AppColors.primaryColor, radius: 10,child: Text('Close',style: buttonText,),)
                          ],
                        ),
                       ),
                     ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}