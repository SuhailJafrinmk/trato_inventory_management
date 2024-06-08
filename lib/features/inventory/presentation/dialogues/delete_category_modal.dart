import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/inventory/bloc/inventory_bloc.dart';
import 'package:trato_inventory_management/widgets/delete_confirm_modal.dart';

void deleteCategory(BuildContext context, String categoryName) {
  showDialog(
      context: context,
      builder: (context) {
        return DeleteConfirmationModal(
          onTapDelete: () {
            BlocProvider.of<InventoryBloc>(context)
                .add(CategoryTileLongpress(categoryName: categoryName));
            Navigator.pop(context);
          },
          onTapCancel: () {
            Navigator.pop(context);
          },
        );
      });
}
