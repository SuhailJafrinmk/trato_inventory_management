import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/widgets/popup_menu_button.dart';

class ProductTile extends StatelessWidget {
  final String productName;
  String subtitle1;
  String subtitle2;
  String productImage;
  Widget? trailingWidget;
  void Function()? onTap;

  ProductTile(
      {super.key,
      required this.productName,
      required this.subtitle1,
      required this.subtitle2,
      required this.productImage,
      this.onTap,
      this.trailingWidget
      });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(productImage ?? AppImages.placeholder),
              fit: BoxFit.cover),
        ),
      ),
      title: Text(productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle1),
          // SizedBox(height: 10,),
          Text(subtitle2),
        ],
      ),
      trailing: trailingWidget,
      // trailing: CustomPopupMenuWidget(menuItems: ['Edit','Delete'],
      //  controller: popupMenuController,
      //  child: Icon(Icons.more_vert),),
    );
  }
}
