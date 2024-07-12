import 'package:flutter/material.dart';
import 'package:trato_inventory_management/features/addsales/widgets/quantity_modal_sales.dart';

void showQuantityModalSales(BuildContext context, Map<String, dynamic> singleDoc ) {
   
  showDialog(
      context: context,
      builder: (context) {
        return QuantityModalSales(
          singleDoc: singleDoc,
        );
      });
}