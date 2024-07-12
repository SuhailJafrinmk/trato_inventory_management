import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/login/cubit/obscure_cubit.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';

class AppTextfield extends StatefulWidget {
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

  const AppTextfield({
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
  State<AppTextfield> createState() => _AppTextfieldState();
}


class _AppTextfieldState extends State<AppTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding, vertical: 8),
      child: SizedBox(
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.labelText,
              style: widget.labelStyle,
            ),
            if (widget.isPassword)
              BlocProvider(
                create: (_) => ObscureCubit(),
                child: BlocBuilder<ObscureCubit, bool>(
                  builder: (context, passwordHidden) {
                    return TextFormField(
                      readOnly: widget.readOnly ?? false,
                      focusNode: widget.focusNode,
                      style: widget.inputStyle,
                      onChanged: widget.onChanged,
                      autovalidateMode: widget.validateMode,
                      obscureText: passwordHidden,
                      keyboardType: widget.inputType,
                      controller: widget.textEditingController,
                      validator: widget.validator,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: widget.fillColor,
                        filled: true,
                        hintText: widget.hintText,
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
                readOnly: widget.readOnly ?? false,
                focusNode: widget.focusNode,
                style: widget.inputStyle,
                onChanged: widget.onChanged,
                autovalidateMode: widget.validateMode,
                obscureText: widget.isPassword,
                keyboardType: widget.inputType,
                controller: widget.textEditingController,
                validator: widget.validator,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: widget.fillColor,
                  filled: true,
                  hintText: widget.hintText,
                  suffixIcon: widget.suffixIcon,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
