import 'package:flutter/material.dart';
import 'package:trato_inventory_management/models/product_model.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';

class ProductGrid extends StatelessWidget {
  // final ProductModel productModel;

  // const ProductGrid({super.key, required this.productModel});

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.productImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Text(
                  'samsung galaxy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'only 2 items on stock',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}