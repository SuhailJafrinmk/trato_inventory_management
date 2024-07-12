import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/inventory/bloc/inventory_bloc.dart';
import 'package:trato_inventory_management/models/category_model.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

void showDialogue(BuildContext context, InventoryBloc inventoryBloc,
    List<String>? categoryNames) {
  showDialog(
      context: context,
      builder: (context) {
        final TextEditingController categoryController =TextEditingController();
        final TextEditingController? descriptionControler =TextEditingController();
        final formkey=GlobalKey<FormState>();
        return Center(
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Add category'),
            content: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextfield(
                      validateMode: AutovalidateMode.onUserInteraction,
                      textEditingController: categoryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please add category name';
                        }
                        if (categoryNames != null) {
                          if (categoryNames.contains(value)) {
                            return 'Category already exist';
                          }
                        }
                        if(value.length>20){
                          return 'Category name should be short';
                        }
                        return null;
                      },
                      labelText: 'Category name',
                      width: double.infinity,
                      padding: 10,
                      fillColor: Colors.white,
                    ),
                    AppTextfield(
                      textEditingController: descriptionControler,
                      labelText: 'Description',
                      width: double.infinity,
                      padding: 10,
                      fillColor: Colors.white,
                    ),
                    CustomButton(
                      onTap: () {
                        if(formkey.currentState!.validate()){
                          inventoryBloc.add(AddCategoryButtonClicked(CategoryModel(
                          category: categoryController.text,
                          description: descriptionControler?.text)));
                        }
                      },
                      height: 60,
                      width: double.infinity,
                      elevation: 10,
                      color: AppColors.primaryColor,
                      radius: 10,
                      child: BlocBuilder<InventoryBloc, InventoryState>(
                        builder: (context, state) {
                          if (state is CategoryAddLoading) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          }
                          return Text(
                            'Add category',
                            style: buttonText,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
