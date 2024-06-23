import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/addstore/bloc/addstore_bloc.dart';
import 'package:trato_inventory_management/models/store_model.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/regex.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class AddStorePage extends StatefulWidget {
  Map<String, dynamic>? storeDetails;
  AddStorePage({this.storeDetails});
  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  TextEditingController storeNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController gstidController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    developer.log("${widget.storeDetails}");
    if (widget.storeDetails != null) {
      storeNameController.text = widget.storeDetails!['storeName'];
      locationController.text = widget.storeDetails!['location'];
      contactController.text = widget.storeDetails!['contactInfo'];
      gstidController.text = widget.storeDetails!['gstId'];
      currencyController.text = widget.storeDetails!['currency'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AddstoreBloc>(context);
    final size = MediaQuery.of(context).size;
    return BlocListener<AddstoreBloc, AddstoreState>(
      listener: (context, state) {
        if (state is AddstoreSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Store added successfully')));
          Navigator.pushReplacementNamed(context, 'login');
        }
        else  if (state is AddstoreError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        else if(state is EditStoreSuccessState){
          Fluttertoast.showToast(
            msg: 'Edited successfully',
            backgroundColor: Colors.green
            );
        }
      },
      child: Scaffold(
        appBar: widget.storeDetails != null
            ? AppBar(
                title: Text('Edit store details'),
              )
            : null,
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: BlocBuilder<AddstoreBloc, AddstoreState>(
                builder: (context, state) {
                  if (state is AddstoreLoading) {
                    return const Center(
                      child: const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.only(top: size.height * .05),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Text(
                            widget.storeDetails != null
                                ? 'Edit store details'
                                : 'Add store details',
                            style: carouselTextLarge,
                          ),
                          AppTextfield(
                            validateMode: AutovalidateMode.onUserInteraction,
                            textEditingController: storeNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a value';
                              }
                              if (value.length > 30) {
                                return 'must be less than 30 characters';
                              }
                              return null;
                            },
                            fillColor: AppColors.backgroundColor,
                            labelText: 'storename',
                            width: size.width * .8,
                            padding: 20,
                            borderColor: Colors.black,
                            labelStyle: labeltextblack,
                          ),
                          AppTextfield(
                            validateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a value';
                              }
                              if (value.length > 50) {
                                return 'must be less than 50 characters';
                              }
                              return null;
                            },
                            textEditingController: locationController,
                            fillColor: AppColors.backgroundColor,
                            labelText: 'Location',
                            width: size.width * .8,
                            padding: 20,
                            borderColor: Colors.black,
                            labelStyle: labeltextblack,
                          ),
                          AppTextfield(
                            validateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a value';
                              }
                              if (!RegexUtils.phoneRegExp.hasMatch(value)) {
                                return 'invalid format';
                              }
                              return null;
                            },
                            textEditingController: contactController,
                            fillColor: AppColors.backgroundColor,
                            labelText: 'Contact',
                            width: size.width * .8,
                            padding: 20,
                            borderColor: Colors.black,
                            labelStyle: labeltextblack,
                          ),
                          AppTextfield(
                            validateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a value';
                              }
                              if (!RegexUtils.gstValidation.hasMatch(value)) {
                                return 'please enter a valid gst id';
                              }
                              return null;
                            },
                            textEditingController: gstidController,
                            fillColor: AppColors.backgroundColor,
                            labelText: 'Gst id',
                            width: size.width * .8,
                            padding: 20,
                            borderColor: Colors.black,
                            labelStyle: labeltextblack,
                          ),
                          AppTextfield(
                            validateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a value';
                              }
                              return null;
                            },
                            textEditingController: currencyController,
                            fillColor: AppColors.backgroundColor,
                            labelText: 'Currency',
                            width: size.width * .8,
                            padding: 20,
                            borderColor: Colors.black,
                            labelStyle: labeltextblack,
                          ),
                          CustomButton(
                            onTap: () {
                              StoreModel storeModel = StoreModel(
                                  storeName: storeNameController.text,
                                  location: locationController.text,
                                  contactInfo: contactController.text,
                                  gstId: gstidController.text,
                                  currency: currencyController.text);
                              if (formkey.currentState!.validate()) {
                                if (widget.storeDetails == null) {
                                  bloc.add(
                                      AddButtonClicked(storeModel: storeModel));
                                } else {
                                  bloc.add(EditButtonClicked(
                                      storeModel: storeModel));
                                }
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
                              }
                            },
                            height: size.height * .07,
                            width: size.width * .8,
                            elevation: 5,
                            color: AppColors.primaryColor,
                            radius: 20,
                            child: BlocBuilder<AddstoreBloc, AddstoreState>(
                              builder: (context, state) {
                                if(state is AddstoreLoading || state is EditStoreLoadingState){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                    Text(widget.storeDetails==null ? 'Adding...' : 'Editing..',style: buttonText),
                                    LoadingAnimationWidget.threeArchedCircle(color:Colors.white, size: 25),
                                  ],);
                                }
                                return Text(
                                  widget.storeDetails != null ? 'Edit' : 'Add',
                                  style: buttonText,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
