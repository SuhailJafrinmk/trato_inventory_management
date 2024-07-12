import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:trato_inventory_management/models/product_model.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';


class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ImagePicker imagePicker=ImagePicker();
  final ImageCropper imageCropper=ImageCropper();
  File? croppedImageFile;
  AddProductBloc() : super(AddProductInitial()) {
   on<DropdownTextfieldClicked>(dropdownTextfieldClicked);
   on<FetchCategoriesEvent>(fetchCategoriesEvent);
   on<AddProductButtonClicked>(addProductButtonClicked);
   on<AddImageButtonClicked>(addImageButtonClicked);
   on<FetchProducts>(fetchProducts);
   on<EditProductClicked>(editProductClicked);

  }

  FutureOr<void> dropdownTextfieldClicked(DropdownTextfieldClicked event, Emitter<AddProductState> emit) {
    emit(CategorySelectedState(newValue: event.selectedItem));
  }
  
  //fetches the categories required to show in the dropdown field for categories the event is called in init state of addproduct page
  FutureOr<void> fetchCategoriesEvent(FetchCategoriesEvent event, Emitter<AddProductState> emit)async{
    try{
      log('evenet started');
      emit(CategoryLoadingState());
     FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    CollectionReference categories = FirebaseFirestore.instance
        .collection('UserData')
        .doc(user!.uid)
        .collection('Category');
    QuerySnapshot querySnapshot = await categories.get();
    //maps every single document names in to a list
      final dropDownItems=querySnapshot.docs.map((doc) =>doc.id).toList();
      emit(FetchingSuccessState(dropDownItems: dropDownItems));
    }catch(e){
      emit(FetchingFailedState(message: e.toString()));
    }
  }
  
  //function for submitting the form to firestore submits the entire data for the product including image
  //this is called on submission of form
  FutureOr<void> addProductButtonClicked(AddProductButtonClicked event, Emitter<AddProductState> emit)async {
    try{
    emit(AddProductLoadingState());
    User ?currentUser=FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    String filename='images/${DateTime.now().millisecondsSinceEpoch}.png';
    Reference storage=FirebaseStorage.instance.ref().child(filename);
    await storage.putFile(File(event.productModel.productImage!.path));
    String imageUrl=await storage.getDownloadURL();
    //model containing all the details of the product
    ProductModel productModel=ProductModel(
      supplier: event.productModel.supplier,
      category: event.productModel.category,
      productName: event.productModel.productName,
      purchasePrice: event.productModel.purchasePrice,
      sellingPrice: event.productModel.sellingPrice,
      productImage: imageUrl,
      description: event.productModel.description
    );
    DocumentReference reference=firestore.collection('UserData').doc(currentUser!.uid);
    //adding the product data to a new collection named products under the document name as product name
    await reference.collection('Products').doc(event.productModel.productName).set(productModel.toMap());
    emit(ProductAddedSuccessState());
    }catch(e){
      emit(AddProductErrorState(message: e.toString()));
    }
  }
  

  //this function is just for picking the image and emit the state 
FutureOr<void> addImageButtonClicked(AddImageButtonClicked event, Emitter<AddProductState> emit) async {
  final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    try {
      //crop the picked image using image cropper
      final croppedFile = await imageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 50,
      );
      
      if (croppedFile != null) {
        final croppedImagePath = croppedFile.path;
        final croppedImageFile = File(croppedImagePath);
        //adding the cropped image to the state
        emit(ImagePickedState(croppedIage: croppedImageFile));
      } else {
       emit(ImageCroppingCancelled());
      }
    } on Exception catch (e) {
      emit(AddImageErrorState(message: e.toString()));
    }
  }
}


  
  FutureOr<void> fetchProducts(FetchProducts event, Emitter<AddProductState> emit) async{
     try{
      emit(FetchProductsLoading());
     FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    CollectionReference categories = FirebaseFirestore.instance
        .collection('UserData')
        .doc(user!.uid)
        .collection('Products');
    QuerySnapshot querySnapshot = await categories.get();
    //maps every single document names in to a list
      final totalItems=querySnapshot.docs.map((doc) =>doc.id).toList();
      emit(FetchProductsSuccess(products: totalItems));
    }catch(e){
      emit(FetchProductsFailed());
    }
  }
  
  FutureOr<void> editProductClicked(EditProductClicked event, Emitter<AddProductState> emit)async{
     try{
    emit(EditProductLoadingState());
    User ?currentUser=FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    String filename='images/${DateTime.now().millisecondsSinceEpoch}.png';
    Reference storage=FirebaseStorage.instance.ref().child(filename);
    await storage.putFile(File(event.productModel.productImage!.path));
    String imageUrl=await storage.getDownloadURL();
    //model containing all the details of the product
    ProductModel productModel=ProductModel(
      supplier: event.productModel.supplier,
      category: event.productModel.category,
      productName: event.productModel.productName,
      purchasePrice: event.productModel.purchasePrice,
      sellingPrice: event.productModel.sellingPrice,
      productImage: imageUrl,
      description: event.productModel.description
    );
    DocumentReference reference=firestore.collection('UserData').doc(currentUser!.uid);
    log('before reaching the adding portion',level: 1000);
    //delete the existing product with the document name of the product
    await reference.collection('Products').doc(event.oldDoc).delete();
    log('old Product document deleted',level: 1000);
    //add the edit as a new product under the document name of the new product
    await reference.collection('Products').doc(event.productModel.productName).set(productModel.toMap());
    log('Edited product added as new product',level: 100);
    emit(EditProductSuccessState());
    }catch(e){
      emit(EditProductErrorState(message: e.toString()));
    }

  }

  }

