import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trato_inventory_management/features/addpurchase/bloc/add_purchase_bloc.dart';
import 'package:trato_inventory_management/models/purchase_record_model.dart';
import 'package:trato_inventory_management/models/purchased_item.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/regex.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

void showCustomerForm(BuildContext context, String typeName, String typeEmail,
    List<PurchasedItem> items) {
  TextEditingController customerController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final customerFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<AddPurchaseBloc, AddPurchaseState>(
                builder: (context, state) {
                  if (state is PurchaseRecordAddLoading) {
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text("adding your purchase record"),
                        ],
                      ),
                    );
                  }
                  return Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextfield(
                          focusNode: customerFocusNode,
                          validateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add a supplier name';
                            }
                            if (value.length > 30) {
                              return 'Please make the name shorter than 30 characters';
                            }
                            return null;
                          },
                          textEditingController: customerController,
                          labelText: typeName,
                          width: double.infinity,
                          padding: 10,
                          obscureText: false,
                          fillColor: Colors.white,
                        ),
                        AppTextfield(
                          focusNode: emailFocusNode,
                          validateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add supplier mail';
                            }
                            if (!RegexUtils.emailRegExp.hasMatch(value)) {
                              return 'Enter a valid mail';
                            }
                            return null;
                          },
                          textEditingController: customerEmailController,
                          labelText: typeEmail,
                          width: double.infinity,
                          padding: 10,
                          obscureText: false,
                          fillColor: Colors.white,
                        ),
                        CustomButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              DateTime now = DateTime.now();
                              String formattedNow =
                                  DateFormat('yyyy-MM-dd – kk:mm').format(now);
                              final totalCount = items.isNotEmpty
                                  ? items
                                      .map((item) => item.totalItemAmount)
                                      .reduce((a, b) => a + b)
                                  : 0;
                              PurchaseRecord record = PurchaseRecord(
                                purchaseDate: formattedNow,
                                items: items,
                                totalAmount: totalCount,
                                supplierEmail: customerEmailController.text,
                                supplierName: customerController.text,
                              );
                              //event meant for handling the purchase record
                              if(record.items.isNotEmpty){
                              BlocProvider.of<AddPurchaseBloc>(context)
                                  .add(AddRecordConfirm(record: record));
                                  
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No items added')));
                              }
                            }
                          },
                          height: 60,
                          width: double.infinity,
                          elevation: 10,
                          color: AppColors.primaryColor,
                          radius: 10,
                          child: Text(
                            'Confirm',
                            style: buttonText,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    },
  ).whenComplete(() {
    customerFocusNode.dispose();
    emailFocusNode.dispose();
  });

  Future.delayed(const Duration(milliseconds: 100), () {
    customerFocusNode.requestFocus();
  });
}