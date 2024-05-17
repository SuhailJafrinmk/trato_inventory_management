import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class AddStorePage extends StatefulWidget {
  const AddStorePage({super.key});

  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  TextEditingController storeNameController=TextEditingController();
  TextEditingController locationController=TextEditingController();
  TextEditingController contactController=TextEditingController();
  TextEditingController gstidController=TextEditingController();
  TextEditingController currencyController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: size.height*.05),
              child: Column(
                children: [
                  Text('Add store details',style: carouselTextLarge,),
                  AppTextfield(
                    obscureText: false,
                    labelText: 'storename',
                   width: size.width*.8,
                    padding: 20,
                    borderColor: Colors.black,
                    labelStyle: labeltextblack,
                    ),
                  AppTextfield(
                    obscureText: false,
                    labelText: 'Location',
                   width: size.width*.8,
                    padding: 20,
                    borderColor: Colors.black,
                    labelStyle: labeltextblack,
                    ),
                  AppTextfield(
                    obscureText: false,
                    labelText: 'Contact',
                     width: size.width*.8,
                      padding: 20,
                      borderColor: Colors.black,
                      labelStyle: labeltextblack,
                      ),
                  AppTextfield(
                    obscureText: false,
                    labelText: 'Gsd id',
                     width: size.width*.8,
                      padding: 20,
                      borderColor: Colors.black,
                      labelStyle: labeltextblack,
                      ),
                  AppTextfield(
                    obscureText: false,
                    labelText: 'Currency',
                     width: size.width*.8,
                      padding: 20,
                      borderColor: Colors.black,
                      labelStyle: labeltextblack,
                      ),
                  CustomButton(
                    height: size.height*.07,
                     width: size.width*.8,
                      elevation: 5,
                       color: AppColors.primaryColor,
                        radius: 20,
                        child: Text('Add',style: buttonText,),)                   
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}