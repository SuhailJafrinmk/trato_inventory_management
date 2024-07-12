import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

// ignore: must_be_immutable
class DeleteConfirmationModal extends StatelessWidget {

  void Function()? onTapDelete;
  void Function()? onTapCancel;

  DeleteConfirmationModal({super.key,this.onTapDelete,this.onTapCancel});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: SizedBox(
        height: height*.2,
        width: width*.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('are you sure you want to delete this item'),
            SizedBox(height: height*.05,),
            Row(
              children: [
                CustomButton(height: height*.05, width: width*.3, elevation: 10, color: AppColors.primaryColor, radius: 10,
                onTap: onTapDelete,child: Text('Delete',style: buttonText,),
                ),
                CustomButton(height: height*.05, width: width*.3, elevation: 10, color: AppColors.primaryColor, radius: 10,
                onTap: onTapCancel,child: Text('Cancel',style: buttonText,),
                )
              ],
            ),
          ],
        ),
      ),

    );
  }
}