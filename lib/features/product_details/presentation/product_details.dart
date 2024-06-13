

import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';


class ProductDetails extends StatelessWidget {
  final Map<String,dynamic>productData;

  const ProductDetails({super.key, required this.productData});
 
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
                  height: size.height*.8,
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
                        image: DecorationImage(image: NetworkImage(productData['productImage'])),
                      ),
                     ),
                     Expanded(
                       child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Product : ${productData['productName']}',style: productTitle,),
                            Text('Purchase Price : ${productData['purchasePrice']}',style: productDescription,),
                            Text('Selling Price : ${productData['sellingPrice']}',style: productDescription,),
                            Text('Supplier : ${productData['supplier']}',style: productDescription,),
                            Text('Product Quantity : ${productData['productQuantity']}',style: productDescription,),
                           Text('Product Description',style: TextStyle(fontSize: 20,),),
                            Text('${productData['description']}' ?? '',style: productDescription,),
                            
                            SizedBox(height: size.height*.02,),
                            CustomButton(height: size.height*.075, width: size.width*.7, elevation: 5, color: AppColors.primaryColor, radius: 10,child: Text('Close',style: buttonText,),onTap: (){
                              Navigator.pop(context);
                            },)
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