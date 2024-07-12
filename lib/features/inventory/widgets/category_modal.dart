import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class CategoryModal extends StatelessWidget {
  const CategoryModal({super.key});
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      height: size.height*.4,
      width: size.width*.8,
      child: Column(
        children: [
          const Text('Add Category'),
          AppTextfield(labelText: 'Category', width: size.width*.8, padding: 10,fillColor: Colors.white,),
          CustomButton(height: size.height*.1, width: size.width*.8, elevation: 10, color: AppColors.primaryColor, radius: 10),
        ],
      ),
    );
  }
}