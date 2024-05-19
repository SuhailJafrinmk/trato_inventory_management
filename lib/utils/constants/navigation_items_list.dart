import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trato_inventory_management/models/navigation_item.dart';

List<NavigationItem>navigationItems=[
  NavigationItem(icon: Icons.home, label: 'Home'),
  NavigationItem(icon: FontAwesomeIcons.warehouse, label: 'inventory'),
  NavigationItem(icon: FontAwesomeIcons.users, label: "customers"),
  NavigationItem(icon: Icons.local_shipping, label: "supplier"),
  NavigationItem(icon: Icons.receipt, label: 'Purchases'),
];

      // BarItem(title: 'inventory', icon: FontAwesomeIcons.warehouse),
      // BarItem(title: 'Customers', icon: FontAwesomeIcons.users),
      // BarItem(title: 'Suppliers', icon: Icons.local_shipping),
      // BarItem(title: "Purchases", icon: Icons.receipt),