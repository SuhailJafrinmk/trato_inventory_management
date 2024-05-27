import 'package:flutter/material.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class DeleteConfirmationModal extends StatelessWidget {
  const DeleteConfirmationModal({super.key});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
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
                CustomButton(height: height*.05, width: width*.3, elevation: 10, color: AppColors.primaryColor, radius: 10,child: Text('Delete',style: buttonText,),),
                CustomButton(height: height*.05, width: width*.3, elevation: 10, color: AppColors.primaryColor, radius: 10,child: Text('Cancel',style: buttonText,),),
              ],
            ),
          ],
        ),
      ),

    );
  }
}