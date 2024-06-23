import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/login/cubit/obscure_cubit.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

class AppTextfield extends StatelessWidget {
  final String labelText;
  final double? width;
  final double padding;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Color borderColor;
  final TextStyle? labelStyle;
  final TextEditingController? textEditingController;
  final TextInputType? inputType;
  final AutovalidateMode? validateMode;
  final String? hintText;
  final void Function(String)? onChanged;
  final TextStyle? inputStyle;
  final Color? fillColor;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool isPassword;

  AppTextfield({
    Key? key,
    required this.labelText,
    this.width,
    required this.padding,
    this.labelStyle,
    this.suffixIcon,
    this.validator,
    this.borderColor = Colors.white,
    this.textEditingController,
    this.inputType,
    this.validateMode,
    this.hintText,
    this.onChanged,
    this.inputStyle,
    this.fillColor = AppColors.primaryColor,
    this.focusNode,
    this.readOnly,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: labelStyle,
            ),
            if (isPassword)
              BlocProvider(
                create: (_) => ObscureCubit(),
                child: BlocBuilder<ObscureCubit, bool>(
                  builder: (context, passwordHidden) {
                    return TextFormField(
                      readOnly: readOnly ?? false,
                      focusNode: focusNode,
                      style: inputStyle,
                      onChanged: onChanged,
                      autovalidateMode: validateMode,
                      obscureText: passwordHidden,
                      keyboardType: inputType,
                      controller: textEditingController,
                      validator: validator,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: fillColor,
                        filled: true,
                        hintText: hintText,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordHidden ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            context.read<ObscureCubit>().toggleVisibility();
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              TextFormField(
                readOnly: readOnly ?? false,
                focusNode: focusNode,
                style: inputStyle,
                onChanged: onChanged,
                autovalidateMode: validateMode,
                obscureText: isPassword,
                keyboardType: inputType,
                controller: textEditingController,
                validator: validator,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: fillColor,
                  filled: true,
                  hintText: hintText,
                  suffixIcon: suffixIcon,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
