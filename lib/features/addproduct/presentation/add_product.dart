import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add product',style: appbartitle,),
      ),
      body: Container(
        
      ),
    );
  }
}