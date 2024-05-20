import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class AddCustomer extends StatelessWidget {
  const AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add customer'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              AppTextfield(labelText: 'Customer name', width: double.infinity, padding: 10, obscureText: false),
               AppTextfield(labelText: 'Place', width: double.infinity, padding: 10, obscureText: false),
                AppTextfield(labelText: 'Email', width: double.infinity, padding: 10, obscureText: false),
                 AppTextfield(labelText: 'Address', width: double.infinity, padding: 10, obscureText: false),
                 CustomButton(height: 70, width: double.infinity, elevation: 10, color: AppColors.primaryColor, radius: 10,)
            ],
          ),
        ),
      ),
    );
  }
}