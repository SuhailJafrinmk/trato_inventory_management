import 'package:flutter/material.dart';

class DropDownTextfield extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;
  final FormFieldValidator<String>? validator;

  const DropDownTextfield({
    Key? key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      value: value,
      onChanged: onChanged,
      validator: validator,
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
