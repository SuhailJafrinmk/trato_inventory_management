import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trato_inventory_management/models/navigation_item.dart';

List<NavigationItem>navigationItems=[
  NavigationItem(icon: Icons.home, label: 'Home'),
  NavigationItem(icon: FontAwesomeIcons.warehouse, label: 'Inventory'),
  NavigationItem(icon: Icons.description, label: "Records"),
  NavigationItem(icon: Icons.person, label: "Profile"),
];
