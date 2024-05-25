import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/widgets/product_tile.dart';

class CategoryProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Smartphones'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: height,
        width: width,
        child: ListView(
          children: [
            ProductTile(productName: 'Samsung galaxy s24', subtitle1: '\$ 1212', subtitle2: '123 in stock', productImage: AppImages.galaxyS24),
            ProductTile(productName: 'Iphone 13 pro', subtitle1: '\$ 1212', subtitle2: '123 in stock', productImage: AppImages.iphone13pro),
            ProductTile(productName: 'Pixel 7A', subtitle1: '\$ 1212', subtitle2: '123 in stock', productImage: AppImages.pixelImage),
            ProductTile(productName: 'Redmi 9A', subtitle1: '\$ 1212', subtitle2: '123 in stock', productImage: AppImages.redmi9a),
            ProductTile(productName: 'Samsung galaxy s24', subtitle1: '\$ 1212', subtitle2: '123 in stock', productImage: AppImages.galaxyS24),
          ],
        ),
      ),
   );
  }
}