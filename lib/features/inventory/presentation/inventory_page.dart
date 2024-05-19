import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/category_grid.dart';
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
                child: IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.white,))),
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
            children: [
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
                 SizedBox(width: size.width*.09,),
               CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.white,))),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                ProductTile(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}