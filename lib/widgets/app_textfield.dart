import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

class AppTextfield extends StatelessWidget {
final String labelText;
double ? width;
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
Color ?fillColor;
FocusNode ?focusNode;
bool ? readOnly;
   AppTextfield({
    super.key, 
    required this.labelText,
    this.width,
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
    this.fillColor=AppColors.primaryColor,
    this.focusNode,
    this.readOnly
    });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding,vertical: 8),
      child: Container(
        width: width,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText,style: labelStyle,),
            TextFormField(
              readOnly: readOnly ?? false,
              focusNode: focusNode,
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
                fillColor: fillColor,
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