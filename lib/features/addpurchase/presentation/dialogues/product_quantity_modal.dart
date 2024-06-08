import 'package:flutter/material.dart';
import 'package:trato_inventory_management/features/addpurchase/widgets/product_quantity_select_modal.dart';
import 'package:trato_inventory_management/models/purchased_item.dart';

void showQuantityModal(BuildContext context, Map<String, dynamic> singleDoc,
    List<PurchasedItem> itemsPurchased) {
  showDialog(
      context: context,
      builder: (context) {
        return QuantityModal(
          singleDoc: singleDoc,
          itemsPurchased: itemsPurchased,
        );
      });
}