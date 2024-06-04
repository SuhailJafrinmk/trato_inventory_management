import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trato_inventory_management/features/addproduct/bloc/add_product_bloc.dart';
import 'package:trato_inventory_management/models/product_model.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';
import 'package:trato_inventory_management/widgets/drop_down_textfield.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? selectedValue;
  List<String> dropDownItems = [];
  final formkey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController minimumQuantityController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  TextEditingController ProductDescriptionController = TextEditingController();
  dynamic pickedImage;
  //  XFile ? pickedImage;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddProductBloc>(context).add(FetchCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<AddProductBloc>(context);
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state is CategorySelectedState) {
          selectedValue = state.newValue;
        } else if (state is FetchingSuccessState) {
          dropDownItems.addAll(state.dropDownItems);
        } else if (state is ProductAddedSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Product added')));
        }else if(state is ImagePickedState){
          pickedImage=state.croppedIage;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add product',
            style: appbartitle,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: BlocBuilder<AddProductBloc, AddProductState>(
                            builder: (context, state) {
                              if (state is CategoryLoadingState) {
                                const Text('Categories are loading...');
                              }

                              return DropDownTextfield(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a category';
                                  }
                                  return null;
                                },
                                label: 'Category',
                                items: dropDownItems,
                                value: selectedValue,
                                onChanged: (newItem) {
                                  bloc.add(DropdownTextfieldClicked(
                                      selectedItem: newItem));
                                },
                              );
                            },
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: DottedBorder(
                          borderType: BorderType.Rect,
                          child: Container(
                            height: 150,
                            child: BlocBuilder<AddProductBloc, AddProductState>(
                              builder: (context, state) {
                                if (state is ImagePickedState) {
                                  return Center(
                                    child: Image.file(
                                        File(state.croppedIage!.path)),
                                  );
                                }
                                return Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Add Image'),
                                      IconButton(
                                          onPressed: () {
                                            bloc.add(AddImageButtonClicked());
                                          },
                                          icon: const Icon(Icons.add)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppTextfield(
                      textEditingController: productNameController,
                      validateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please add a product name';
                        }
                        if (value.trim().length > 30) {
                          return 'Product length should be less than 30';
                        }
                        return null;
                      },
                      fillColor: Colors.white,
                      labelText: 'Product',
                      width: double.infinity,
                      padding: 10,
                      obscureText: false),
                  AppTextfield(
                    textEditingController: purchasePriceController,
                    validateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'please add Purchase price';
                      }
                      if (value.trim().length > 10) {
                        return 'Product price should be less than 10';
                      }
                      return null;
                    },
                    fillColor: Colors.white,
                    labelText: 'Purchase Price',
                    width: double.infinity,
                    padding: 10,
                    obscureText: false,
                    inputType: TextInputType.number,
                  ),
                  AppTextfield(
                    textEditingController: sellingPriceController,
                    validateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'please add selling price';
                      }
                      if (value.trim().length > 50) {
                        return 'Product length should be less than 30';
                      }
                      return null;
                    },
                    fillColor: Colors.white,
                    labelText: 'Selling price',
                    width: double.infinity,
                    padding: 10,
                    obscureText: false,
                    inputType: TextInputType.number,
                  ),
                  AppTextfield(
                    textEditingController: minimumQuantityController,
                    validateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'please add minimum quantity';
                      }
                      if (value.trim().length > 2) {
                        return 'Minimum quantity should be less than 100';
                      }
                      return null;
                    },
                    fillColor: Colors.white,
                    labelText: 'Minimum Quantity',
                    width: double.infinity,
                    padding: 10,
                    obscureText: false,
                    inputType: TextInputType.number,
                  ),
                  AppTextfield(
                      textEditingController: supplierController,
                      validateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please add supplier name';
                        }
                        if (value.trim().length > 50) {
                          return 'supplier name should be less than 30 characters';
                        }
                        return null;
                      },
                      fillColor: Colors.white,
                      labelText: 'Supplier',
                      width: double.infinity,
                      padding: 10,
                      obscureText: false),
                  AppTextfield(
                      textEditingController: ProductDescriptionController,
                      validateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please add a description';
                        }
                        if (value.trim().length > 50) {
                          return 'less than 100 characters';
                        }
                        return null;
                      },
                      fillColor: Colors.white,
                      labelText: 'Description',
                      width: double.infinity,
                      padding: 10,
                      obscureText: false),
                  CustomButton(
                    height: 70,
                    width: double.infinity,
                    elevation: 10,
                    color: AppColors.primaryColor,
                    radius: 10,
                    child: BlocBuilder<AddProductBloc, AddProductState>(
                      builder: (context, state) {
                        if (state is AddProductLoadingState) {
                          return CircularProgressIndicator();
                        }
                        return Text(
                          'Add product',
                          style: buttonText,
                        );
                      },
                    ),
                    onTap: () {
                      if(!formkey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form not valid')));
                      }
                      if (formkey.currentState!.validate()) {
                        print(formkey.currentState);
                              bloc.add(AddProductButtonClicked(
                                  productModel: ProductModel(
                                    supplier: supplierController.text,
                                      category: selectedValue!,
                                      productName: productNameController.text,
                                      purchasePrice: int.parse(
                                          purchasePriceController.text),
                                      sellingPrice: int.parse(
                                          sellingPriceController.text),
                                      minimumQuantity: int.parse(
                                          minimumQuantityController.text),
                                      description:
                                          ProductDescriptionController.text,
                                      productImage: pickedImage
                                      )));
                            
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
