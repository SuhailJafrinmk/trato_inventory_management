import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/samsung galaxy s24.jpg')),
        ),
      ),
    );
  }
}