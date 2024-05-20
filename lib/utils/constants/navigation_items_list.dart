import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trato_inventory_management/models/navigation_item.dart';

List<NavigationItem>navigationItems=[
  NavigationItem(icon: Icons.home, label: 'Home'),
  NavigationItem(icon: FontAwesomeIcons.warehouse, label: 'inventory'),
  NavigationItem(icon: FontAwesomeIcons.users, label: "customers"),
  NavigationItem(icon: Icons.local_shipping, label: "supplier"),
  NavigationItem(icon: Icons.receipt, label: 'Purchases'),
  NavigationItem(icon: Icons.storage, label: 'Records'),
];
