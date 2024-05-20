import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/customer_tile.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(child: Column(
      children: [
        SizedBox(height: size.height*.01,),
        Text('Customers',style: categoryTitle,),
        SizedBox(
          height: size.height*.75,
          width: size.width,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children:<Widget> [
              CustomerTile(),
              CustomerTile(),
               CustomerTile(),
              CustomerTile(),
               CustomerTile(),
              CustomerTile(),
               CustomerTile(),
              CustomerTile(),
               CustomerTile(),
              CustomerTile(),
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