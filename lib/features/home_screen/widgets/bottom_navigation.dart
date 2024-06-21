import 'package:flutter/material.dart';
import 'package:trato_inventory_management/models/navigation_item.dart';

class ScrollableBottomNavigationBar extends StatelessWidget {
  final List<NavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;

  ScrollableBottomNavigationBar({
    required this.items,
    required this.selectedIndex,
    required this.onItemTapped,
    this.backgroundColor = Colors.blue,
    this.selectedItemColor = Colors.white,
    this.unselectedItemColor = Colors.white70,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          int index = items.indexOf(item);
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onItemTapped(index),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? backgroundColor.withOpacity(0.2) : backgroundColor,
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    item.icon,
                    color: isSelected ? selectedItemColor : unselectedItemColor,
                  ),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? selectedItemColor : unselectedItemColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
