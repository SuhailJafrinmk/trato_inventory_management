import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

class AppTextfield extends StatelessWidget {
final String labelText;
final double width;
final double padding;
Widget ?suffixIcon;
String? Function(String?)? validator;
Color borderColor;
TextStyle ?labelStyle;
TextEditingController ?textEditingController;
TextInputType? inputType;
bool obscureText;
AutovalidateMode? validateMode;
String?hintText;
void Function(String)? onChanged;
TextStyle? inputStyle;
   AppTextfield({
    super.key, 
    required this.labelText,
    required this.width,
    required this.padding,
    required this.obscureText,
    this.labelStyle,
    this.suffixIcon,
    this.validator,
    this.borderColor=Colors.white,
    this.textEditingController,
    this.inputType,
    this.validateMode,
    this.hintText,
    this.onChanged,
    this.inputStyle,
    });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding,vertical: 8),
      child: Container(
        width: width,
        // decoration: BoxDecoration(
        //   border: Border(bottom: BorderSide(color: borderColor))
        // ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText,style: labelStyle,),
            TextFormField(
              
              style: inputStyle,
              onChanged: onChanged,
              autovalidateMode: validateMode,
              obscureText: obscureText,
              keyboardType: inputType,
              controller: textEditingController,
              validator: validator,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  )
                ),
                fillColor: AppColors.primaryColor,
                filled: true,
              suffix: suffixIcon,
              hintText: hintText,
              ),
            )
          ],
        )
      ),
    );
  }
}