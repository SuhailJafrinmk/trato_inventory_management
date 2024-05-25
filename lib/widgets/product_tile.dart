import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';

class ProductTile extends StatelessWidget {
final String productName;
 String subtitle1;
 String subtitle2;
String productImage;

ProductTile({super.key, required this.productName, required this.subtitle1,required this.subtitle2,required this.productImage});
List <DropdownMenuItem<dynamic>> dropdownItems=[const DropdownMenuItem(child: Text('Delete')),const DropdownMenuItem(child: Text("Edit"))];
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, 'product_details'),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(productImage),fit:BoxFit.cover ),
        ),
      ),
      title:  Text(productName),
      subtitle:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle1),
          Text(subtitle2),
        ],
      ),
      // trailing: DropdownButton(items: dropdownItems, onChanged: (dynamic){})
    );
  }
}