import 'package:flutter/material.dart';
import 'package:trato_inventory_management/widgets/purchase_tile.dart';

class PurchasesList extends StatelessWidget {
  const PurchasesList({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase records'),
      ),
      body: SafeArea(child: Column(
        children: [
          
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
        ],
      )
      ),
    );
  }
}