import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/inventory/bloc/inventory_bloc.dart';
import 'package:trato_inventory_management/widgets/delete_confirm_modal.dart';

void deleteProduct(BuildContext context, Map<String, dynamic>? document) {
  showDialog(
      context: context,
      builder: (context) {
        return DeleteConfirmationModal(
          onTapDelete: () {
            BlocProvider.of<InventoryBloc>(context)
                .add(DeleteConfirmationClicked(document: document));
            Navigator.pop(context);
          },
          onTapCancel: () {
            Navigator.pop(context);
          },
        );
      });
}