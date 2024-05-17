import 'package:flutter/material.dart';

class ProductGrid extends StatefulWidget {
  final String productImage;
  final String ProductName;
  final String stockOutText;

  const ProductGrid({super.key, required this.productImage, required this.ProductName, required this.stockOutText});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      height: size.height*.03,
      width: size.width*.03,
    child: Column(
      children: [
        Image.asset(widget.productImage,fit: BoxFit.cover,),
        Text(widget.ProductName),
        Text(widget.stockOutText),
      ],
    ),
    );
  }
}