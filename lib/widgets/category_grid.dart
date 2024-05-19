import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

class CategoryTile extends StatelessWidget {
  // final Category category;
final String categoryname;

  const CategoryTile({super.key, required this.categoryname});
  // const CategoryTile({@required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      // width: 50,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.category, size: 40, color: Colors.black),
          SizedBox(height: 8),
          Text(
            categoryname,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
