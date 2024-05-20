import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/customer_tile.dart';
import 'package:trato_inventory_management/widgets/supplier_tile.dart';

class SupplierPage extends StatelessWidget {
  const SupplierPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: [
        SizedBox(
          height: size.height * .01,
        ),
        Text(
          'Suppliers',
          style: categoryTitle,
        ),
        SizedBox(
            height: size.height * .75,
            width: size.width,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: const[
                SupplierTile(),
                SupplierTile(),
                SupplierTile(),
                SupplierTile(),
                SupplierTile(),
                SupplierTile(),
                SupplierTile(),
                SupplierTile(),
                SupplierTile(),
                SupplierTile(),
            
              ],
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'add_customer');
            },
            child: Text('Add Supplier')),
      ],
    ));
  }
}
