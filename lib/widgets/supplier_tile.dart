import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupplierTile extends StatelessWidget {
  const SupplierTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/supplier.png'),
      ),
      title: Text('sahal industries'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Narikkuni'),
          Text('sahalindustries@gmail.com'),
        ],
      ),
    );
  }
}