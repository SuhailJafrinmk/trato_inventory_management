import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/addsales/bloc/add_sales_bloc.dart';
import 'package:trato_inventory_management/models/sales_record_model.dart';
import 'package:trato_inventory_management/models/selled_item.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/regex.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

void showCustomerForm(BuildContext context, String customerName, String customerEmail) {
  TextEditingController customerController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final customerFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final currentState = BlocProvider.of<AddSalesBloc>(context).state;
  List<SelledItem> itemsSelled = [];
  if (currentState is ItemQuanityAdded) {
    itemsSelled.addAll(currentState.itemsAdded);
  }
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
              child: BlocBuilder<AddSalesBloc, AddSalesState>(
                builder: (context, state) {
                  if (state is CustomerDetailsAddLoading) {
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
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
                              return 'Please add customer name';
                            }
                            if (value.length > 30) {
                              return 'Please make the name shorter than 30 characters';
                            }
                            return null;
                          },
                          textEditingController: customerController,
                          labelText: customerName,
                          width: double.infinity,
                          padding: 10,
                          fillColor: Colors.white,
                        ),
                        AppTextfield(
                          focusNode: emailFocusNode,
                          validateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add Customer mail';
                            }
                            if (!RegexUtils.emailRegExp.hasMatch(value)) {
                              return 'Enter a valid mail';
                            }
                            return null;
                          },
                          textEditingController: customerEmailController,
                          labelText: customerEmail,
                          width: double.infinity,
                          padding: 10,
                          fillColor: Colors.white,
                        ),
                        CustomButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              DateTime now = DateTime.now();
                              Timestamp timestamp=Timestamp.fromDate(now);
                              final totalCount = itemsSelled.isNotEmpty
                                  ? itemsSelled
                                      .map((item) => item.totalItemAmount)
                                      .reduce((a, b) => a + b)
                                  : 0;
                              SalesRecordModel record = SalesRecordModel(
                                saleDate: timestamp,
                                items: itemsSelled,
                                totalAmount: totalCount,
                                customerEmail: customerEmailController.text,
                                customerName: customerController.text,
                              );
                              //event meant for handling the purchase record
                              BlocProvider.of<AddSalesBloc>(context).add(ConfirmCompleteSales(salesRecordModel: record));
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