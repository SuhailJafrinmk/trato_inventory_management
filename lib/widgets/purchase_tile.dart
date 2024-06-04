import 'package:flutter/material.dart';

class PurchaseTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/purchase_image.jpg'),
      ),
      title: Text('Purchase 112'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('02/07/2024'),
        ],
      ),
    );
  }
}
