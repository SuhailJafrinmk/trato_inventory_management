import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_dropdown.dart';
import 'package:trato_inventory_management/widgets/product_grid.dart';
import 'package:trato_inventory_management/widgets/product_tile.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String selected_item='mobile tech';
     print('width of device:$width');
     print('height of device:$height');
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Purchase'),
      ),
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                    children: [
                   Row(
                     children: [
             Container(
              // padding: EdgeInsets.all(),
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20)
              ),
              
                  child: CustomDropdownButton<String>(items: ['mobile tech','apple suppliers','dialogue'],
                   value: selected_item,
               
                     onChanged: (String ?newValue){
                      print('new value $newValue');
                      setState(() {
                        selected_item=newValue!;
                        print('value of selected item $selected_item');
                      });
                     }),
             ),
                     ],
                   ),
                   SizedBox(height: 20,),
                 SizedBox(
          height: 300,
          width: width,
          child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 2 / 3,
        children: [
          // ProductGrid(),
          // ProductGrid(),
          // ProductGrid(),
        ],
        ),
        ),
        Expanded(child: Container(
          width: width,
          decoration: BoxDecoration(
            border: Border.all()
          ),
          child: Column(
            children: [
              Text('Grand totel:\$ 343434',style: biggestTextBlack,),
              SizedBox(height: 20,),
              SizedBox(
                height: 200,
                width: width,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    ProductTile(),
                    ProductTile(),
                    ProductTile(),
                    ProductTile(),
                    ProductTile(),

                  ],
                ),
              ),
            ],
          ),
        ))
                    ],
                  ),
          )
          ),
    );
  }
}
