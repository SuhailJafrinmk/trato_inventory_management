import 'package:flutter/material.dart';
import 'package:trato_inventory_management/models/product_model.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';

class ProductTile extends StatelessWidget {
  // ProductModel? productModel;
List <DropdownMenuItem<dynamic>> dropdownItems=[DropdownMenuItem(child: Text('Delete')),DropdownMenuItem(child: Text("Edit"))];
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.productImage),fit:BoxFit.cover ),
        ),
      ),
      title: Text('Samsung galaxy s22'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('500 \$'),
          Text('250 unii in stock'),
        ],
      ),
      // trailing: DropdownButton(items: dropdownItems, onChanged: (dynamic){})
    );
  }
}