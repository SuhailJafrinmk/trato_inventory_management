import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/addstore/bloc/addstore_bloc.dart';
import 'package:trato_inventory_management/models/store_model.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/regex.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';

class AddStorePage extends StatefulWidget {
  const AddStorePage({super.key});

  @override
  State<AddStorePage> createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  TextEditingController storeNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController gstidController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  final formkey=GlobalKey<FormState>();

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
        if (state is AddstoreError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: BlocBuilder<AddstoreBloc, AddstoreState>(
                builder: (context, state) {
                  if(state is AddstoreLoading){
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
                            'Add store details',
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
                            obscureText: false,
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
                            obscureText: false,
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
                            obscureText: false,
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
                            obscureText: false,
                            labelText: 'Gsd id',
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
                            obscureText: false,
                            labelText: 'Currency',
                            width: size.width * .8,
                            padding: 20,
                            borderColor: Colors.black,
                            labelStyle: labeltextblack,
                          ),
                          CustomButton(
                            // onTap: () => Navigator.pushNamed(context,'home_screen'),
                            onTap: () {
                              StoreModel storeModel = StoreModel(
                                  storeName: storeNameController.text,
                                  location: locationController.text,
                                  contactInfo: contactController.text,
                                  gstId: gstidController.text,
                                  currency: currencyController.text);
                              if(formkey.currentState!.validate()){
                                bloc.add(AddButtonClicked(storeModel: storeModel));
                              }
                            },
                            height: size.height * .07,
                            width: size.width * .8,
                            elevation: 5,
                            color: AppColors.primaryColor,
                            radius: 20,
                            child: Text(
                              'Add',
                              style: buttonText,
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
