import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit product',
          style: appbartitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  AppTextfield(
                    fillColor: Colors.white,
                      labelText: 'Category',
                      width: size.width * .5,
                      padding: 10,
                      obscureText: false),
                  Expanded(
                    child: DottedBorder(
                      borderType: BorderType.Rect,
                      child: Container(
                        height: 150,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Edit Image'),
                              IconButton(onPressed: (){}, icon: Icon(Icons.add)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppTextfield(
                fillColor: Colors.white,
                  labelText: 'Product',
                  width: double.infinity,
                  padding: 10,
                  obscureText: false),
              AppTextfield(
                fillColor: Colors.white,
                labelText: 'Purchase Price',
                width: double.infinity,
                padding: 10,
                obscureText: false,
                inputType: TextInputType.number,
              ),
              AppTextfield(
                fillColor: Colors.white,
                labelText: 'Selling price',
                width: double.infinity,
                padding: 10,
                obscureText: false,
                inputType: TextInputType.number,
              ),
              AppTextfield(
                fillColor: Colors.white,
                labelText: 'Minimum Quantity',
                width: double.infinity,
                padding: 10,
                obscureText: false,
                inputType: TextInputType.number,
              ),
              AppTextfield(
                fillColor: Colors.white,
                  labelText: 'Description',
                  width: double.infinity,
                  padding: 10,
                  obscureText: false),
              CustomButton(
                height: 70,
                width: double.infinity,
                elevation: 10,
                color: AppColors.primaryColor,
                radius: 10,
                child: Text(
                  'Edit',
                  style: buttonText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
