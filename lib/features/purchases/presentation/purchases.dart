import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/customer_tile.dart';
import 'package:trato_inventory_management/widgets/purchase_tile.dart';

class PurchasesList extends StatelessWidget {
  const PurchasesList({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(child: Column(
      children: [
        SizedBox(height: size.height*.01,),
        Text('Purchase records',style: categoryTitle,),
        SizedBox(
          height: size.height*.75,
          width: size.width,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children:<Widget> [
              PurchaseTile(),
              PurchaseTile(),
              PurchaseTile(),
            ],
          )),
        ElevatedButton(onPressed: (){
          Navigator.pushNamed(context, 'add_customer');
        }, child: Text('Add customer')),
      ],
    )
    );
  }
}