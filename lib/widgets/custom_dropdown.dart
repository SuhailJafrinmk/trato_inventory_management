import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<T> items;
  final T value;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isDense;
  final bool isExpanded;
  final ValueChanged<T?>? onChanged;

   CustomDropdownButton({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense = true,
    this.isExpanded = false,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(7),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isDense: isDense,
          isExpanded: isExpanded,
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
