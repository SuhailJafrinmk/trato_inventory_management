import 'package:flutter/material.dart';
import 'package:trato_inventory_management/features/addpurchase/widgets/product_quantity_select_modal.dart';

void showQuantityModal(BuildContext context, Map<String, dynamic> singleDoc) {
  showDialog(
      context: context,
      builder: (context) {
        return QuantityModal(
          singleDoc: singleDoc,
        );
      });
}