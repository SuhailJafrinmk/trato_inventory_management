import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/image_links.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/category_grid.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';
import 'package:trato_inventory_management/widgets/product_tile.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      child: SafeArea(child: Column(
        children: [
          SizedBox(height: size.height*.02,),
          Row(
            children: [
              Text('Categories',style: categoryTitle,),
              SizedBox(width: size.width*.09,),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: IconButton(onPressed: (){
                  print('clicked add button');
                  show_dialogue(context);
                }, icon: Icon(Icons.add,color: Colors.white,))),
            ],
          ),
          SizedBox(height: size.height*.02,),
          SizedBox(
            height: size.height*.3,

            child: GridView.count(
              childAspectRatio: 3/2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              crossAxisCount:2,
            scrollDirection: Axis.vertical,
            children:const[
              CategoryTile(categoryname: 'Smartphone'),
              CategoryTile(categoryname: 'Laptops'),
              CategoryTile(categoryname: 'Accesories'),
              CategoryTile(categoryname: 'Earphones'),
               CategoryTile(categoryname: 'Smartphone'),
              CategoryTile(categoryname: 'Laptops'),
              CategoryTile(categoryname: 'Accesories'),
              CategoryTile(categoryname: 'Earphones'),
            ],
             ),
          ),
            SizedBox(height: size.height*.02,),
          Row(
            children: [
              Text('Products',style: categoryTitle,),
                 SizedBox(width: size.width*.15,),
               CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: IconButton(onPressed: (){
                  Navigator.pushNamed(context, 'add_product');
                }, icon: Icon(Icons.add,color: Colors.white,))),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
               ProductTile(productName: 'samsung galaxy s24',productImage: AppImages.galaxyS24,subtitle1: '500 \$',subtitle2: '100 units in stock',),
               ProductTile(productName: 'Pixel 7a',productImage: AppImages.pixelImage,subtitle1: '500 \$',subtitle2: '100 units in stock',),
               ProductTile(productName: 'Asus rogue',productImage: AppImages.asusRogue,subtitle1: '500 \$',subtitle2: '100 units in stock',),
               ProductTile(productName: 'samsung galaxy s24',productImage: AppImages.galaxyS24,subtitle1: '500 \$',subtitle2: '100 units in stock',),
               ProductTile(productName: 'Iphone 13 pro',productImage: AppImages.iphone13pro,subtitle1: '500 \$',subtitle2: '100 units in stock',),
               ProductTile(productName: 'samsung galaxy s24',productImage: AppImages.galaxyS24,subtitle1: '500 \$',subtitle2: '100 units in stock',),
               ProductTile(productName: 'Pixel 7a',productImage: AppImages.pixelImage,subtitle1: '500 \$',subtitle2: '100 units in stock',),
               ProductTile(productName: 'Asus rogue',productImage: AppImages.asusRogue,subtitle1: '500 \$',subtitle2: '100 units in stock',),
               ProductTile(productName: 'samsung galaxy s24',productImage: AppImages.galaxyS24,subtitle1: '500 \$',subtitle2: '100 units in stock',),
               ProductTile(productName: 'Iphone 13 pro',productImage: AppImages.iphone13pro,subtitle1: '500 \$',subtitle2: '100 units in stock',),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

void show_dialogue(BuildContext context){
  showDialog(context: context, builder: (context){
   return Dialog(
    child: Container(
      padding: EdgeInsets.all(20),
      height: 300,
      width: 300,
      child: Column(
        children: [
          Text('Add category',style: categoryTitle,),
          const SizedBox(height: 20,),
          AppTextfield(labelText: 'Category', width: 200, padding: 10, obscureText: false),
          CustomButton(onTap: () => Navigator.pop(context),  height: 60, width: 200, elevation: 10, color: AppColors.primaryColor, radius: 10,child: Text('Add category',style: buttonText,),),
        ],
      ),
    ),
   );
  });
}