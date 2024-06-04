import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/inventory/bloc/inventory_bloc.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class DeleteConfirmationModal extends StatelessWidget {

  Map<String,dynamic>?document;

  DeleteConfirmationModal({super.key,this.document});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    final bloc=BlocProvider.of<InventoryBloc>(context);
    return AlertDialog(
      title: Text('Confirm Deletion'),
      content: SizedBox(
        height: height*.2,
        width: width*.8,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('are you sure you want to delete this item'),
            SizedBox(height: height*.05,),
            Row(
              children: [
                CustomButton(height: height*.05, width: width*.3, elevation: 10, color: AppColors.primaryColor, radius: 10,child: Text('Delete',style: buttonText,),onTap: () {
                  bloc.add(DeleteConfirmationClicked(document: document));
                },),
                CustomButton(height: height*.05, width: width*.3, elevation: 10, color: AppColors.primaryColor, radius: 10,child: Text('Cancel',style: buttonText,),),
              ],
            ),
          ],
        ),
      ),

    );
  }
}