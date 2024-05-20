import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: CircleAvatar(
        child: Icon(FontAwesomeIcons.user),
      ),
      title: Text('Suhail jafrin'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trivandrum'),
          Text('suhail@gmail.com'),
        ],
      ),
    );
  }
}