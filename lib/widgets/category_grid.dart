import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

class CategoryTile extends StatelessWidget {

final String categoryname;
void Function()? onTap;
  CategoryTile({super.key, required this.categoryname,this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
