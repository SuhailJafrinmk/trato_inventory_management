import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trato_inventory_management/features/addproduct/bloc/add_product_bloc.dart';
import 'package:trato_inventory_management/models/product_model.dart';
import 'package:trato_inventory_management/utils/constants/colors.dart';
import 'package:trato_inventory_management/utils/constants/text_styles.dart';
import 'package:trato_inventory_management/utils/constants/validations.dart';
import 'package:trato_inventory_management/widgets/app_textfield.dart';
import 'package:trato_inventory_management/widgets/custom_button.dart';
import 'package:trato_inventory_management/widgets/drop_down_textfield.dart';

class AddProduct extends StatefulWidget {
  Map<String, dynamic>? document;
  String? categoryName;
  AddProduct({this.document,this.categoryName});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? selectedValue;
  List<String> dropDownItems = [];
  List<String> availableProducts = [];
  final formkey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  dynamic pickedImage;
  TextEditingController categorycontroller=TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.document != null) {
      selectedValue = widget.document!['category'];
      productNameController.text = widget.document!['productName'];
      purchasePriceController.text =
      widget.document!['purchasePrice'].toString();
      sellingPriceController.text = widget.document!['sellingPrice'].toString();
      supplierController.text = widget.document!['supplier'];
      productDescriptionController?.text = widget.document!['description'];
      pickedImage = widget.document!['productImage'];
    }
    if(widget.categoryName!=null){
      categorycontroller.text=widget.categoryName ?? '';
    }
    BlocProvider.of<AddProductBloc>(context).add(FetchCategoriesEvent());
    BlocProvider.of<AddProductBloc>(context).add(FetchProducts());
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state is CategorySelectedState) {
          selectedValue = state.newValue;
        } else if (state is FetchingSuccessState) {
          dropDownItems.addAll(state.dropDownItems);
        } else if (state is ProductAddedSuccessState) {
          BlocProvider.of<AddProductBloc>(context).add(FetchProducts());
           Fluttertoast.showToast(msg: 'Product added succesfully',backgroundColor: Colors.green);
           Navigator.pop(context);
        } else if (state is ImagePickedState) {
          pickedImage = state.croppedIage;
        } else if (state is FetchProductsSuccess) {
          availableProducts.addAll(state.products);
        } else if (state is EditProductSuccessState) {
           Fluttertoast.showToast(msg: 'Product edited succesfully',backgroundColor: Colors.green);
           Navigator.pop(context);
        }else if(state is AddProductErrorState){
          Fluttertoast.showToast(msg: 'Please add product image',backgroundColor: Colors.red);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            widget.document==null ? 'Add Product' : 'Edit product',
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
                                return const AutoSizeText('Categories are loading...');
                              }
                              return widget.categoryName != null ? 
                              AppTextfield(
                                textEditingController: categorycontroller,
                                readOnly: true,
                              fillColor: Colors.white,
                              labelText: 'Category',
                              padding: 10,
                               ) : 
                             DropDownTextfield(
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
                                  //event meant for updating the state of the dropdown textfield selected item
                                  BlocProvider.of<AddProductBloc>(context).add(DropdownTextfieldClicked(selectedItem: newItem));
                                      
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
                          child: SizedBox(
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
                                      const AutoSizeText('Add Image'),
                                      IconButton(
                                          onPressed: () {
                                            BlocProvider.of<AddProductBloc>(
                                                    context)
                                                .add(
                                                    AddImageButtonClicked()); //event meant for adding image of the product
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
                  //textfield to add product name
                  AppTextfield(
                      textEditingController: productNameController,
                      validateMode: AutovalidateMode.onUserInteraction,
                      validator: (p0) =>
                          AppValidations.productName(p0, availableProducts),
                      fillColor: Colors.white,
                      labelText: 'Product',
                      width: double.infinity,
                      padding: 10,
                      ),
                  //textfield for adding purchase price of the product
                  AppTextfield(
                    textEditingController: purchasePriceController,
                    validateMode: AutovalidateMode.onUserInteraction,
                    validator: (p0) => AppValidations.purchasePrice(p0),
                    fillColor: Colors.white,
                    labelText: 'Purchase Price',
                    width: double.infinity,
                    padding: 10,
                    inputType: TextInputType.number,
                  ),
                  //textfield for adding selling price of the product
                  AppTextfield(
                    textEditingController: sellingPriceController,
                    validateMode: AutovalidateMode.onUserInteraction,
                    validator: (p0) => AppValidations.sellingPrice(p0),
                    fillColor: Colors.white,
                    labelText: 'Selling price',
                    width: double.infinity,
                    padding: 10,
                    inputType: TextInputType.number,
                  ),             
                  //textfield for adding the supplier name of the product
                  AppTextfield(
                      textEditingController: supplierController,
                      validateMode: AutovalidateMode.onUserInteraction,
                      validator: (p0) => AppValidations.supplierName(p0),
                      fillColor: Colors.white,
                      labelText: 'Supplier',
                      width: double.infinity,
                      padding: 10,
                      ),
                  //textfield for adding a short description for the product which is not necessary
                  AppTextfield(
                      textEditingController: productDescriptionController,
                      fillColor: Colors.white,
                      labelText: 'Description',
                      width: double.infinity,
                      padding: 10,
                      ),
                  CustomButton(
                    height: 70,
                    width: double.infinity,
                    elevation: 10,
                    color: AppColors.primaryColor,
                    radius: 10,
                    child: BlocBuilder<AddProductBloc, AddProductState>(
                      builder: (context, state) {
                        if (state is AddProductLoadingState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Adding product',style: buttonText,),
                              LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 20)
                            ],

                          );
                        }
                            if(state is EditProductLoadingState){
                              return const CircularProgressIndicator();
                            }
                            return Text(
                              widget.document==null ? 'Add Product' : 'Edit product',
                              style: buttonText,
                            );
                      },
                    ),
                    onTap: () {
                      if (!formkey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Form not valid'),backgroundColor: Colors.red,));
                      }
                      if (formkey.currentState!.validate()) {
                        final product = ProductModel(
                            supplier: supplierController.text,
                            category: widget.categoryName ?? selectedValue,
                            productName: productNameController.text,
                            purchasePrice:int.parse(purchasePriceController.text),
                            sellingPrice:int.parse(sellingPriceController.text),
                            description:productDescriptionController?.text ?? '',
                            productImage: pickedImage);
                        if (widget.document == null) {
                          BlocProvider.of<AddProductBloc>(context).add(
                              AddProductButtonClicked(productModel: product));
                        } else {
                          final String? oldDoc =widget.document?['productName'];
                          BlocProvider.of<AddProductBloc>(context).add(
                              EditProductClicked(
                                  productModel: product, oldDoc: oldDoc));
                        }
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
